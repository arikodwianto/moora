from django.shortcuts import render, redirect
from .models import Pelanggan, Pesanan, Kriteria, Nilai
from django.utils import timezone
from django.shortcuts import get_object_or_404, render
from django.http import HttpResponse
from weasyprint import HTML
from .models import Pesanan

from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm, PasswordChangeForm
from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect
from django.contrib import messages

# Register view
def register_view(request):
    if request.method == "POST":
        form = UserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('login')
    else:
        form = UserCreationForm()
    return render(request, 'register.html', {'form': form})

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
    
    return render(request, 'login.html', {'form': form})


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
    return render(request, 'profile.html')

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
    return render(request, 'change_password.html', {'form': form})



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
    return render(request, 'tambah_pelanggan.html')


@login_required
def list_pelanggan(request):
    data = Pelanggan.objects.all()
    return render(request, 'list_pelanggan.html', {'pelanggan': data})


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
    return render(request, 'ubah_pelanggan.html', {'pelanggan': pelanggan})


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
    return render(request, 'tambah_pesanan.html', {'pelanggan_list': pelanggan_list})

@login_required
def list_pesanan(request):
    data = Pesanan.objects.all()
    return render(request, 'list_pesanan.html', {'pesanan': data})

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
    return render(request, 'ubah_pesanan.html', {'pesanan': pesanan, 'pelanggan_list': pelanggan_list})

@login_required
def hapus_pesanan(request, id):
    pesanan = get_object_or_404(Pesanan, id=id)
    pesanan.delete()
    messages.success(request, "Pesanan berhasil dihapus.")
    return redirect('list_pesanan')


from django.shortcuts import render
from django.db.models.functions import ExtractMonth, ExtractYear
from django.http import HttpResponse
from weasyprint import HTML
from django.template.loader import render_to_string
import datetime

import datetime
from django.shortcuts import render
from .models import Pesanan  # sesuaikan import model

@login_required
def laporan_pesanan_bulanan(request):
    bulan = request.GET.get('bulan')
    tahun = request.GET.get('tahun')

    pesanan = Pesanan.objects.all()

    if bulan and tahun:
        pesanan = pesanan.filter(
            tanggal_pesan__year=tahun,
            tanggal_pesan__month=bulan
        )
    else:
        sekarang = datetime.date.today()
        bulan = sekarang.month
        tahun = sekarang.year
        pesanan = pesanan.filter(
            tanggal_pesan__year=tahun,
            tanggal_pesan__month=bulan
        )

    bulan_list = range(1, 13)
    tahun_list = range(2022, datetime.date.today().year + 1)  # dari 2022 sampai tahun sekarang

    context = {
        'pesanan': pesanan,
        'bulan': int(bulan),
        'tahun': int(tahun),
        'bulan_list': bulan_list,
        'tahun_list': tahun_list,
    }
    return render(request, 'laporan_pesanan_bulanan.html', context)

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

    html_string = render_to_string('laporan_pesanan_bulanan_pdf.html', context)
    html = HTML(string=html_string)
    pdf = html.write_pdf()

    response = HttpResponse(pdf, content_type='application/pdf')
    response['Content-Disposition'] = f'filename=laporan_pesanan_{tahun}_{bulan}.pdf'
    return response




# Tambah Kriteria
from django.shortcuts import render, redirect, get_object_or_404
from .models import Kriteria

# ➕ Tambah Kriteria
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect, get_object_or_404

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
    return render(request, 'tambah_kriteria.html')

@login_required
def list_kriteria(request):
    data = Kriteria.objects.all()
    return render(request, 'list_kriteria.html', {'kriteria': data})

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
    return render(request, 'ubah_kriteria.html', {'kriteria': kriteria})

@login_required
def hapus_kriteria(request, id):
    kriteria = get_object_or_404(Kriteria, id=id)
    kriteria.delete()
    messages.success(request, "Kriteria berhasil dihapus.")
    return redirect('list_kriteria')




# Tambah Nilai
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect, get_object_or_404

@login_required
def tambah_nilai(request):
    pesanan_list = Pesanan.objects.all()
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
    return render(request, 'tambah_nilai.html', {'pesanan_list': pesanan_list, 'kriteria_list': kriteria_list})

@login_required
def list_nilai(request):
    data = Nilai.objects.all()
    return render(request, 'list_nilai.html', {'nilai': data})

@login_required
def ubah_nilai(request, id):
    nilai_obj = get_object_or_404(Nilai, id=id)
    if request.method == "POST":
        nilai_obj.nilai = request.POST['nilai']
        nilai_obj.save()
        messages.success(request, "Nilai berhasil diubah.")
        return redirect('list_nilai')
    return render(request, 'ubah_nilai.html', {'nilai': nilai_obj})

@login_required
def hapus_nilai(request, id):
    nilai_obj = get_object_or_404(Nilai, id=id)
    nilai_obj.delete()
    messages.success(request, "Nilai berhasil dihapus.")
    return redirect('list_nilai')




import numpy as np

import numpy as np
from django.shortcuts import render
from .models import Pelanggan, Pesanan, Kriteria, Nilai

@login_required
def hasil_moora(request):
    kriteria_list = list(Kriteria.objects.all())
    bobot = np.array([k.bobot for k in kriteria_list])
    tipe = [k.tipe_kriteria for k in kriteria_list]

    pesanan_list = list(Pesanan.objects.all())
    matrix = []

    # Ambil matriks keputusan (X)
    for pesanan in pesanan_list:
        row = []
        for k in kriteria_list:
            nilai_obj = Nilai.objects.filter(pesanan=pesanan, kriteria=k).first()
            if nilai_obj:
                row.append(float(nilai_obj.nilai))
            else:
                row.append(0)
        matrix.append(row)

    X = np.array(matrix, dtype=float)
    if X.size == 0:
        return render(request, 'hasil_moora.html', {'hasil': []})

    # 1️⃣ Normalisasi
    denom = np.sqrt((X**2).sum(axis=0))
    R = X / denom

    # 2️⃣ Optimasi nilai atribut (dikali bobot)
    Y = R * bobot

    # 3️⃣ Hitung nilai preferensi (benefit - cost)
    S = []
    for i in range(len(Y)):
        benefit_sum = sum(Y[i][j] for j in range(len(kriteria_list)) if tipe[j] == 'benefit')
        cost_sum = sum(Y[i][j] for j in range(len(kriteria_list)) if tipe[j] == 'cost')
        skor = benefit_sum - cost_sum
        S.append({
            'pesanan': pesanan_list[i],
            'skor': skor
        })

    # 4️⃣ Perangkingan
    ranking = sorted(S, key=lambda x: x['skor'], reverse=True)
    for idx, item in enumerate(ranking, start=1):
        item['rank'] = idx

    return render(request, 'hasil_moora.html', {
        'kriteria_list': kriteria_list,
        'pesanan_list': pesanan_list,
        'matrix': X,
        'normalisasi': R,
        'optimasi': Y,
        'preferensi': S,
        'ranking': ranking
    })

from django.template.loader import render_to_string
from django.http import HttpResponse
from weasyprint import HTML
import numpy as np

@login_required
def cetak_hasil_moora_pdf(request):
    kriteria_list = list(Kriteria.objects.all())
    bobot = np.array([k.bobot for k in kriteria_list])
    tipe = [k.tipe_kriteria for k in kriteria_list]

    pesanan_list = list(Pesanan.objects.all())
    matrix = []

    for pesanan in pesanan_list:
        row = []
        for k in kriteria_list:
            nilai_obj = Nilai.objects.filter(pesanan=pesanan, kriteria=k).first()
            if nilai_obj:
                row.append(float(nilai_obj.nilai))
            else:
                row.append(0)
        matrix.append(row)

    X = np.array(matrix, dtype=float)
    if X.size == 0:
        ranking = []
    else:
        denom = np.sqrt((X**2).sum(axis=0))
        R = X / denom
        Y = R * bobot
        S = []
        for i in range(len(Y)):
            benefit_sum = sum(Y[i][j] for j in range(len(kriteria_list)) if tipe[j] == 'benefit')
            cost_sum = sum(Y[i][j] for j in range(len(kriteria_list)) if tipe[j] == 'cost')
            skor = benefit_sum - cost_sum
            S.append({
                'pesanan': pesanan_list[i],
                'skor': skor
            })
        ranking = sorted(S, key=lambda x: x['skor'], reverse=True)
        for idx, item in enumerate(ranking, start=1):
            item['rank'] = idx

    # Render HTML dari template
    html_string = render_to_string('hasil_moora_pdf.html', {
        'ranking': ranking,
        'kriteria_list': kriteria_list,
    })

    # Buat PDF dari HTML pakai WeasyPrint
    html = HTML(string=html_string)
    pdf_file = html.write_pdf()

    response = HttpResponse(pdf_file, content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="hasil_moora.pdf"'
    return response

@login_required
def dashboard(request):
    jumlah_pelanggan = Pelanggan.objects.count()
    jumlah_pesanan = Pesanan.objects.count()
    jumlah_kriteria = Kriteria.objects.count()
    jumlah_nilai = Nilai.objects.count()
    return render(request, 'dashboard.html', {
        'jumlah_pelanggan': jumlah_pelanggan,
        'jumlah_pesanan': jumlah_pesanan,
        'jumlah_kriteria': jumlah_kriteria,
        'jumlah_nilai': jumlah_nilai,
    })
