from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse
from django.contrib import messages
from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm, PasswordChangeForm
from django.contrib.auth.decorators import login_required
from django.db.models.functions import ExtractMonth, ExtractYear
from django.template.loader import render_to_string

from .models import Pelanggan, Pesanan, Kriteria, Nilai

from django.utils import timezone
from weasyprint import HTML
import datetime
import numpy as np



# Register view
def register_view(request):
    if request.method == "POST":
        form = UserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('login')
    else:
        form = UserCreationForm()
    return render(request, 'auth/register.html', {'form': form})

# Login view
def login_view(request):
    if request.user.is_authenticated:
        messages.success(request, "Anda sudah login.")
        return redirect('profile')
    
    if request.method == "POST":
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            messages.success(request, f"Selamat datang, {user.username}!")
            return redirect('dashboard')
        else:
            messages.error(request, "Login gagal! Username atau password salah.")
    else:
        form = AuthenticationForm()
    
    return render(request, 'auth/login.html', {'form': form})


# Logfrom django.contrib import messages
from django.contrib.auth import logout
from django.shortcuts import redirect

def logout_view(request):
    logout(request)
    messages.success(request, "Anda berhasil logout.")
    return redirect('login')

# Profile view (tampilkan info user dan link ubah password)
@login_required
def profile_view(request):
    return render(request, 'auth/profile.html')

# Ubah password
@login_required
def change_password(request):
    if request.method == "POST":
        form = PasswordChangeForm(request.user, request.POST)
        if form.is_valid():
            user = form.save()
            # biar session tetap login setelah ganti password
            update_session_auth_hash(request, user)
            return redirect('profile')
    else:
        form = PasswordChangeForm(request.user)
    return render(request, 'auth/change_password.html', {'form': form})



# Tambah Pelanggan
@login_required
def tambah_pelanggan(request):
    if request.method == "POST":
        nama = request.POST['nama']
        alamat = request.POST['alamat']
        no_hp = request.POST['no_hp']
        Pelanggan.objects.create(
            nama_pelanggan=nama,
            alamat=alamat,
            no_hp=no_hp,
        )
        messages.success(request, "Data pelanggan berhasil ditambahkan.")
        return redirect('list_pelanggan')
    return render(request, 'pelanggan/tambah_pelanggan.html')


@login_required
def list_pelanggan(request):
    data = Pelanggan.objects.all()
    return render(request, 'pelanggan/list_pelanggan.html', {'pelanggan': data})


@login_required
def ubah_pelanggan(request, id):
    pelanggan = get_object_or_404(Pelanggan, id=id)
    if request.method == "POST":
        pelanggan.nama_pelanggan = request.POST['nama']
        pelanggan.alamat = request.POST['alamat']
        pelanggan.no_hp = request.POST['no_hp']
        pelanggan.save()
        messages.success(request, "Data pelanggan berhasil diubah.")
        return redirect('list_pelanggan')
    return render(request, 'pelanggan/ubah_pelanggan.html', {'pelanggan': pelanggan})


@login_required
def hapus_pelanggan(request, id):
    pelanggan = get_object_or_404(Pelanggan, id=id)
    pelanggan.delete()
    messages.success(request, "Data pelanggan berhasil dihapus.")
    return redirect('list_pelanggan')



# Tambah Pesanan
# Tambah Pesanan
@login_required
def tambah_pesanan(request):
    pelanggan_list = Pelanggan.objects.all()
    if request.method == "POST":
        pelanggan_id = request.POST['pelanggan']
        jumlah_galon = request.POST['jumlah_galon']
        tanggal_pengiriman = request.POST['tanggal_pengiriman']
        Pesanan.objects.create(
            pelanggan_id=pelanggan_id,
            tanggal_pesan=timezone.now(),
            jumlah_galon=jumlah_galon,
            tanggal_pengiriman=tanggal_pengiriman
        )
        messages.success(request, "Pesanan berhasil ditambahkan.")
        return redirect('list_pesanan')
    return render(request, 'pesanan/tambah_pesanan.html', {'pelanggan_list': pelanggan_list})

@login_required
def list_pesanan(request):
    data = Pesanan.objects.all()
    total_selesai = Pesanan.objects.filter(status=True).count()
    total_belum = Pesanan.objects.filter(status=False).count()

    context = {
        'pesanan': data,
        'total_selesai': total_selesai,
        'total_belum': total_belum,
    }
    return render(request, 'pesanan/list_pesanan.html', context)


@login_required
def ubah_pesanan(request, id):
    pesanan = get_object_or_404(Pesanan, id=id)
    pelanggan_list = Pelanggan.objects.all()
    if request.method == "POST":
        pesanan.pelanggan_id = request.POST['pelanggan']
        pesanan.jumlah_galon = request.POST['jumlah_galon']
        pesanan.tanggal_pengiriman = request.POST['tanggal_pengiriman']
        pesanan.save()
        messages.success(request, "Pesanan berhasil diubah.")
        return redirect('list_pesanan')
    return render(request, 'pesanan/ubah_pesanan.html', {'pesanan': pesanan, 'pelanggan_list': pelanggan_list})

@login_required
def hapus_pesanan(request, id):
    pesanan = get_object_or_404(Pesanan, id=id)
    pesanan.delete()
    messages.success(request, "Pesanan berhasil dihapus.")
    return redirect('list_pesanan')

@login_required
def selesai_pesanan(request, id):
    pesanan = get_object_or_404(Pesanan, id=id)
    pesanan.status = True
    pesanan.save()
    messages.success(request, "Pesanan telah diselesaikan.")
    return redirect('list_pesanan')




import datetime
from django.db.models import Count
from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from .models import Pesanan

@login_required
def laporan_pesanan_bulanan(request):
    # ambil filter dari request
    bulan = request.GET.get('bulan')
    tahun = request.GET.get('tahun')

    if not bulan or not tahun:
        sekarang = datetime.date.today()
        bulan = sekarang.month
        tahun = sekarang.year

    bulan = int(bulan)
    tahun = int(tahun)

    # filter data pesanan
    pesanan = Pesanan.objects.filter(
        tanggal_pesan__year=tahun,
        tanggal_pesan__month=bulan
    )

    # hitung jumlah pesanan per hari dalam bulan terpilih
    data_harian = (
        pesanan.values('tanggal_pesan')
        .annotate(total=Count('id'))
        .order_by('tanggal_pesan')
    )

    labels = [p['tanggal_pesan'].strftime("%d-%m") for p in data_harian]
    data = [p['total'] for p in data_harian]

    bulan_list = range(1, 13)
    tahun_list = range(2022, datetime.date.today().year + 1)

    context = {
        'pesanan': pesanan,
        'bulan': bulan,
        'tahun': tahun,
        'bulan_list': bulan_list,
        'tahun_list': tahun_list,
        'labels': labels,  # untuk chart
        'data': data,      # untuk chart
    }
    return render(request, 'laporan/laporan_pesanan_bulanan.html', context)


@login_required
def cetak_laporan_pesanan_bulanan(request):
    bulan = request.GET.get('bulan')
    tahun = request.GET.get('tahun')

    if not bulan or not tahun:
        return HttpResponse("Bulan dan tahun harus dipilih")

    pesanan = Pesanan.objects.filter(
        tanggal_pesan__year=tahun,
        tanggal_pesan__month=bulan
    )

    context = {
        'pesanan': pesanan,
        'bulan': int(bulan),
        'tahun': int(tahun),
    }

    html_string = render_to_string('laporan/laporan_pesanan_bulanan_pdf.html', context)
    html = HTML(string=html_string)
    pdf = html.write_pdf()

    response = HttpResponse(pdf, content_type='application/pdf')
    response['Content-Disposition'] = f'filename=laporan_pesanan_{tahun}_{bulan}.pdf'
    return response




# Tambah Kriteria


@login_required
def tambah_kriteria(request):
    if request.method == "POST":
        nama_kriteria = request.POST['nama_kriteria']
        bobot = request.POST['bobot']
        tipe = request.POST['tipe']
        Kriteria.objects.create(
            nama_kriteria=nama_kriteria,
            bobot=bobot,
            tipe_kriteria=tipe
        )
        messages.success(request, "Kriteria berhasil ditambahkan.")
        return redirect('list_kriteria')
    return render(request, 'kriteria/tambah_kriteria.html')

@login_required
def list_kriteria(request):
    data = Kriteria.objects.all()
    return render(request, 'kriteria/list_kriteria.html', {'kriteria': data})

@login_required
def ubah_kriteria(request, id):
    kriteria = get_object_or_404(Kriteria, id=id)
    if request.method == "POST":
        kriteria.nama_kriteria = request.POST['nama_kriteria']
        kriteria.bobot = request.POST['bobot']
        kriteria.tipe_kriteria = request.POST['tipe']
        kriteria.save()
        messages.success(request, "Kriteria berhasil diubah.")
        return redirect('list_kriteria')
    return render(request, 'kriteria/ubah_kriteria.html', {'kriteria': kriteria})

@login_required
def hapus_kriteria(request, id):
    kriteria = get_object_or_404(Kriteria, id=id)
    kriteria.delete()
    messages.success(request, "Kriteria berhasil dihapus.")
    return redirect('list_kriteria')




# Tambah Nilai


@login_required
def tambah_nilai(request):
    # hanya ambil pesanan yang belum selesai
    pesanan_list = Pesanan.objects.filter(status=False)
    kriteria_list = Kriteria.objects.all()

    if request.method == "POST":
        pesanan_id = request.POST['pesanan']
        for k in kriteria_list:
            nilai = request.POST.get(f'kriteria_{k.id}')
            Nilai.objects.create(
                pesanan_id=pesanan_id,
                kriteria=k,
                nilai=nilai
            )
        messages.success(request, "Nilai berhasil ditambahkan.")
        return redirect('list_nilai')
    
    return render(request, 'alternatif/tambah_nilai.html', {
        'pesanan_list': pesanan_list,
        'kriteria_list': kriteria_list
    })

@login_required
def list_nilai(request):
    data = Nilai.objects.select_related('pesanan', 'kriteria').all()
    return render(request, 'alternatif/list_nilai.html', {'nilai': data})


@login_required
def ubah_nilai(request, id):
    nilai_obj = get_object_or_404(Nilai, id=id)
    if request.method == "POST":
        nilai_obj.nilai = request.POST['nilai']
        nilai_obj.save()
        messages.success(request, "Nilai berhasil diubah.")
        return redirect('list_nilai')
    return render(request, 'alternatif/ubah_nilai.html', {'nilai': nilai_obj})

@login_required
def hapus_nilai(request, id):
    nilai_obj = get_object_or_404(Nilai, id=id)
    nilai_obj.delete()
    messages.success(request, "Nilai berhasil dihapus.")
    return redirect('list_nilai')




import numpy as np
from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from .models import Kriteria, Pesanan, Nilai

@login_required
def hasil_moora(request):
    # Ambil semua kriteria
    kriteria_list = list(Kriteria.objects.all())

    # Ambil hanya pesanan yang belum selesai (status=False)
    pesanan_list = list(Pesanan.objects.filter(status=False))

    if not kriteria_list or not pesanan_list:
        return render(request, 'hasil/hasil_moora.html', {'ranking': []})

    bobot = np.array([k.bobot for k in kriteria_list], dtype=float)
    tipe = [k.tipe_kriteria for k in kriteria_list]

    # Matriks keputusan (X)
    X = []
    for pesanan in pesanan_list:
        row = []
        for k in kriteria_list:
            nilai = Nilai.objects.filter(pesanan=pesanan, kriteria=k).first()
            row.append(float(nilai.nilai) if nilai else 0)
        X.append(row)
    X = np.array(X, dtype=float)

    # Normalisasi
    denom = np.sqrt((X ** 2).sum(axis=0))
    denom[denom == 0] = 1
    R = X / denom

    # Optimasi (R * bobot)
    Y = R * bobot

    # Hitung preferensi
    hasil = []
    for i, pesanan in enumerate(pesanan_list):
        benefit = sum(Y[i][j] for j in range(len(kriteria_list)) if tipe[j] == "benefit")
        cost = sum(Y[i][j] for j in range(len(kriteria_list)) if tipe[j] == "cost")
        skor = benefit - cost
        hasil.append({
            "pesanan": pesanan,
            "x": X[i],
            "r": R[i],
            "y": Y[i],
            "skor": skor
        })

    # Ranking
    ranking = sorted(hasil, key=lambda d: d["skor"], reverse=True)
    for idx, item in enumerate(ranking, start=1):
        item["rank"] = idx

    return render(request, "hasil/hasil_moora.html", {
        "kriteria_list": kriteria_list,
        "hasil": hasil,
        "ranking": ranking
    })



import numpy as np
from django.http import HttpResponse
from django.template.loader import render_to_string
from weasyprint import HTML

@login_required
def cetak_hasil_moora_pdf(request):
    kriteria_list = list(Kriteria.objects.all())
    pesanan_list = list(Pesanan.objects.all())

    if not kriteria_list or not pesanan_list:
        ranking = []
    else:
        bobot = np.array([k.bobot for k in kriteria_list], dtype=float)
        tipe = [k.tipe_kriteria for k in kriteria_list]

        # Matriks keputusan
        X = []
        for pesanan in pesanan_list:
            row = []
            for k in kriteria_list:
                nilai = Nilai.objects.filter(pesanan=pesanan, kriteria=k).first()
                row.append(float(nilai.nilai) if nilai else 0)
            X.append(row)
        X = np.array(X, dtype=float)

        # Normalisasi
        denom = np.sqrt((X ** 2).sum(axis=0))
        denom[denom == 0] = 1
        R = X / denom

        # Optimasi
        Y = R * bobot

        # Hitung skor preferensi
        hasil = []
        for i, pesanan in enumerate(pesanan_list):
            benefit = sum(Y[i][j] for j in range(len(kriteria_list)) if tipe[j] == "benefit")
            cost = sum(Y[i][j] for j in range(len(kriteria_list)) if tipe[j] == "cost")
            skor = benefit - cost
            hasil.append({
                "pesanan": pesanan,
                "x": list(X[i]),
                "r": list(R[i]),
                "y": list(Y[i]),
                "skor": skor
            })

        ranking = sorted(hasil, key=lambda d: d["skor"], reverse=True)
        for idx, item in enumerate(ranking, start=1):
            item["rank"] = idx

    # Render ke template PDF
    html_string = render_to_string("hasil/hasil_moora_pdf.html", {
        "kriteria_list": kriteria_list,
        "ranking": ranking,
    })

    pdf_file = HTML(string=html_string).write_pdf()

    response = HttpResponse(pdf_file, content_type="application/pdf")
    response["Content-Disposition"] = 'attachment; filename="hasil_moora.pdf"'
    return response


import datetime
from django.db.models import Count
from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from .models import Pelanggan, Pesanan, Kriteria, Nilai

import datetime
from django.db.models import Count
from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from .models import Pelanggan, Pesanan, Kriteria, Nilai

@login_required
def dashboard(request):
    # Statistik umum
    jumlah_pelanggan = Pelanggan.objects.count()
    jumlah_pesanan = Pesanan.objects.count()
    jumlah_kriteria = Kriteria.objects.count()
    jumlah_nilai = Nilai.objects.count()

    # Ambil filter tahun dari request
    tahun_sekarang = datetime.date.today().year
    tahun = request.GET.get('tahun', tahun_sekarang)
    tahun = int(tahun)

    # Data pesanan per bulan sesuai tahun dipilih
    pesanan_bulanan = (
        Pesanan.objects.filter(tanggal_pesan__year=tahun)
        .values('tanggal_pesan__month')
        .annotate(total=Count('id'))
        .order_by('tanggal_pesan__month')
    )

    labels = []
    data = []
    bulan_nama = ["Jan","Feb","Mar","Apr","Mei","Jun",
                  "Jul","Agu","Sep","Okt","Nov","Des"]

    for i in range(1, 13):
        labels.append(bulan_nama[i-1])
        found = next((p['total'] for p in pesanan_bulanan if p['tanggal_pesan__month'] == i), 0)
        data.append(found)

    # daftar tahun dari 2022 sampai tahun sekarang
    tahun_list = range(2022, tahun_sekarang + 1)

    return render(request, 'dashboard.html', {
        'jumlah_pelanggan': jumlah_pelanggan,
        'jumlah_pesanan': jumlah_pesanan,
        'jumlah_kriteria': jumlah_kriteria,
        'jumlah_nilai': jumlah_nilai,
        'labels': labels,
        'data': data,
        'tahun': tahun,
        'tahun_list': tahun_list,
    })


