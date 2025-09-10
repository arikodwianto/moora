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



# views.py

from django.contrib import messages
from django.contrib.auth import login, logout
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm
from django.contrib.auth.models import User, Group
from django.shortcuts import render, redirect

from django.contrib.auth.models import User, Group
from django.contrib.auth.forms import UserCreationForm, UserChangeForm
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.contrib.auth.decorators import user_passes_test

# Login view
def login_view(request):
    if request.user.is_authenticated:
        messages.success(request, "Anda sudah login.")
        # Arahkan sesuai role
        if request.user.is_superuser:
            return redirect("owner_dashboard")
        elif request.user.groups.filter(name="Admin").exists():
            return redirect("admin_dashboard")
        else:
            return redirect("profile")
    
    if request.method == "POST":
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            messages.success(request, f"Selamat datang, {user.username}!")

            # Cek role
            if user.is_superuser:
                return redirect("dashboard")
            elif user.groups.filter(name="Admin").exists():
                return redirect("admin_dashboard")
            else:
                return redirect("profile")
        else:
            messages.error(request, "Login gagal! Username atau password salah.")
    else:
        form = AuthenticationForm()
    
    return render(request, "auth/login.html", {"form": form})



# Logout view
def logout_view(request):
    logout(request)
    messages.success(request, "Anda berhasil logout.")
    return redirect('login')


# Profile view
@login_required
def profile_view(request):
    return render(request, 'auth/profile.html')


# Hanya Owner bisa buat Admin
def is_owner(user):
    return user.is_superuser

def is_admin(user):
    return user.groups.filter(name="Admin").exists()

@user_passes_test(is_owner)
def list_admin_view(request):
    admin_group, created = Group.objects.get_or_create(name="Admin")
    admins = User.objects.filter(groups=admin_group)
    return render(request, "auth/list_admin.html", {"admins": admins})


@user_passes_test(is_owner)
def add_admin_view(request):
    if request.method == "POST":
        form = UserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            admin_group = Group.objects.get(name="Admin")
            user.groups.add(admin_group)
            messages.success(request, f"Akun Admin '{user.username}' berhasil dibuat.")
            return redirect("list_admin")
    else:
        form = UserCreationForm()
    return render(request, "auth/add_admin.html", {"form": form})


@user_passes_test(is_owner)
def edit_admin_view(request, user_id):
    user = get_object_or_404(User, id=user_id)
    form = UserChangeForm(request.POST or None, instance=user)

    if request.method == "POST":
        if form.is_valid():
            form.save()
            messages.success(request, f"Akun Admin '{user.username}' berhasil diperbarui.")
            return redirect("list_admin")

    return render(request, "auth/edit_admin.html", {"form": form, "user": user})


@user_passes_test(is_owner)
def delete_admin_view(request, user_id):
    user = get_object_or_404(User, id=user_id)
    username = user.username
    user.delete()
    messages.success(request, f"Akun Admin '{username}' berhasil dihapus.")
    return redirect("list_admin")



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
@user_passes_test(is_admin)
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
@user_passes_test(is_admin)
def list_pelanggan(request):
    data = Pelanggan.objects.all()
    return render(request, 'pelanggan/list_pelanggan.html', {'pelanggan': data})


@login_required
@user_passes_test(is_admin)
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
@user_passes_test(is_admin)
def hapus_pelanggan(request, id):
    pelanggan = get_object_or_404(Pelanggan, id=id)
    pelanggan.delete()
    messages.success(request, "Data pelanggan berhasil dihapus.")
    return redirect('list_pelanggan')




# Tambah Pesanan
# Tambah Pesanan
@login_required
@user_passes_test(is_admin)
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
@user_passes_test(is_admin)
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
@user_passes_test(is_admin)
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
@user_passes_test(is_admin)
def hapus_pesanan(request, id):
    pesanan = get_object_or_404(Pesanan, id=id)
    pesanan.delete()
    messages.success(request, "Pesanan berhasil dihapus.")
    return redirect('list_pesanan')

@login_required
@user_passes_test(is_admin)
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
@user_passes_test(is_owner)
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

from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from .models import Kriteria

from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from .models import Kriteria

@login_required
def tambah_kriteria(request):
    if request.method == "POST":
        nama_kriteria = request.POST.get('nama_kriteria', '').strip()
        tipe = request.POST.get('tipe')

        try:
            bobot = float(request.POST.get('bobot', 0))
        except ValueError:
            messages.error(request, "Bobot harus berupa angka.")
            return redirect('tambah_kriteria')

        # Hitung total bobot terbaru
        total_bobot_saat_ini = sum(k.bobot for k in Kriteria.objects.all())
        sisa_bobot = max(0, round(1 - total_bobot_saat_ini, 6))

        # Validasi bobot tidak melebihi sisa
        if bobot - sisa_bobot > 1e-6:
            messages.error(request, f"Bobot terlalu besar. Sisa bobot yang bisa diinput: {sisa_bobot:.2f}")
            return redirect('tambah_kriteria')
        
        # Cek jika total bobot sudah 1
        total_bobot_baru = total_bobot_saat_ini + bobot
        if abs(total_bobot_baru - 1) > 1e-6 and total_bobot_baru > 1:
            messages.error(request, f"Total bobot harus tepat 1. Sekarang: {total_bobot_baru:.2f}")
            return redirect('tambah_kriteria')


        Kriteria.objects.create(
            nama_kriteria=nama_kriteria,
            bobot=bobot,
            tipe_kriteria=tipe
        )
        messages.success(request, "Kriteria berhasil ditambahkan.")
        return redirect('list_kriteria')

    # GET request → ambil total bobot terbaru lagi
    total_bobot_saat_ini = sum(k.bobot for k in Kriteria.objects.all())
    sisa_bobot = max(0, round(1 - total_bobot_saat_ini, 6))

    return render(request, 'kriteria/tambah_kriteria.html', {
        'sisa_bobot': sisa_bobot
    })




@login_required
def ubah_kriteria(request, id):
    kriteria = get_object_or_404(Kriteria, id=id)
    if request.method == "POST":
        bobot_baru = float(request.POST['bobot'])

        total_bobot = (
            sum(k.bobot for k in Kriteria.objects.exclude(id=id)) + bobot_baru
        )
        if abs(total_bobot - 1) > 0.0001:
            messages.error(request, f"Total bobot harus 1. Sekarang: {total_bobot:.2f}")
            return redirect('ubah_kriteria', id=id)

        kriteria.nama_kriteria = request.POST['nama_kriteria']
        kriteria.bobot = bobot_baru
        kriteria.tipe_kriteria = request.POST['tipe']
        kriteria.save()
        messages.success(request, "Kriteria berhasil diubah.")
        return redirect('list_kriteria')
    return render(request, 'kriteria/ubah_kriteria.html', {'kriteria': kriteria})


@login_required
def list_kriteria(request):
    data = Kriteria.objects.all()
    total_bobot = sum(k.bobot for k in data)

    # cek status bobot
    status_bobot = None
    if abs(total_bobot - 1) < 1e-6:  
        status_bobot = "pas"
    elif total_bobot < 1:
        status_bobot = "kurang"
    else:
        status_bobot = "lebih"

    return render(request, 'kriteria/list_kriteria.html', {
        'kriteria': data,
        'total_bobot': round(total_bobot, 2),  # biar rapi
        'status_bobot': status_bobot,
        'sisa_bobot': round(1 - total_bobot, 2) if total_bobot < 1 else 0
    })



@login_required
def hapus_kriteria(request, id):
    kriteria = get_object_or_404(Kriteria, id=id)
    kriteria.delete()  # hapus dari database
    messages.success(request, "Kriteria berhasil dihapus.")
    # redirect ke tambah_kriteria agar sisa bobot terbaru langsung muncul
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
    response["Content-Disposition"] = 'inline; filename="hasil_moora.pdf"'
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

from django.contrib.auth.decorators import login_required
from django.db.models import Count
from django.shortcuts import render, redirect
from django.contrib import messages
import datetime
from .models import Pelanggan, Pesanan, Kriteria, Nilai


@login_required
def admin_dashboard(request):
    # Batasi hanya untuk user di Group Admin
    if not request.user.groups.filter(name="Admin").exists():
        messages.error(request, "Anda tidak punya akses ke halaman ini.")
        return redirect("login")
    
    

    # Statistik umum
    jumlah_pelanggan = Pelanggan.objects.count()
    jumlah_pesanan = Pesanan.objects.count()
    jumlah_kriteria = Kriteria.objects.count()
    jumlah_nilai = Nilai.objects.count()

    # Ambil filter tahun dari request
    tahun_sekarang = datetime.date.today().year
    tahun = int(request.GET.get('tahun', tahun_sekarang))

    # Data pesanan per bulan sesuai tahun dipilih
    pesanan_bulanan = (
        Pesanan.objects.filter(tanggal_pesan__year=tahun)
        .values('tanggal_pesan__month')
        .annotate(total=Count('id'))
        .order_by('tanggal_pesan__month')
    )

    labels = []
    data = []
    bulan_nama = ["Jan", "Feb", "Mar", "Apr", "Mei", "Jun",
                  "Jul", "Agu", "Sep", "Okt", "Nov", "Des"]

    for i in range(1, 13):
        labels.append(bulan_nama[i - 1])
        found = next((p['total'] for p in pesanan_bulanan if p['tanggal_pesan__month'] == i), 0)
        data.append(found)

    # daftar tahun dari 2022 sampai tahun sekarang
    tahun_list = range(2022, tahun_sekarang + 1)

    return render(request, "admin_dashboard.html", {
        "jumlah_pelanggan": jumlah_pelanggan,
        "jumlah_pesanan": jumlah_pesanan,
        "jumlah_kriteria": jumlah_kriteria,
        "jumlah_nilai": jumlah_nilai,
        "labels": labels,
        "data": data,
        "tahun": tahun,
        "tahun_list": tahun_list,
    })
