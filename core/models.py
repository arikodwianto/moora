from django.db import models
from django.contrib.auth.models import User, Group
from django.contrib.auth.decorators import user_passes_test
from django.contrib.auth.forms import UserCreationForm
from django.shortcuts import render, redirect
from django.contrib import messages


def is_owner(user):
    return user.is_superuser  # hanya superuser yang dianggap owner


@user_passes_test(is_owner)
def add_admin_view(request):
    if request.method == "POST":
        form = UserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            # Tambah ke group Admin
            admin_group = Group.objects.get(name="Admin")
            user.groups.add(admin_group)
            messages.success(request, f"Akun Admin '{user.username}' berhasil dibuat.")
            return redirect("dashboard")
    else:
        form = UserCreationForm()
    return render(request, "auth/add_admin.html", {"form": form})


class Pelanggan(models.Model):
    nama_pelanggan = models.CharField(max_length=200)
    alamat = models.TextField()
    no_hp = models.CharField(max_length=20)

    def __str__(self):
        return self.nama_pelanggan


class Pesanan(models.Model):
    pelanggan = models.ForeignKey(Pelanggan, on_delete=models.CASCADE)
    tanggal_pesan = models.DateField()
    jumlah_galon = models.IntegerField()
    tanggal_pengiriman = models.DateField()
    status = models.BooleanField(default=False)  # False = Belum selesai, True = Selesai

    def __str__(self):
        return f"{self.pelanggan.nama_pelanggan} - {self.jumlah_galon} galon"


class Pengiriman(models.Model):
    pesanan = models.ForeignKey(Pesanan, on_delete=models.CASCADE)
    tanggal_kirim = models.DateField()
    status_pengiriman = models.CharField(max_length=50)

    def __str__(self):
        return f"Pengiriman {self.id} - {self.pesanan}"

class Kriteria(models.Model):
    nama_kriteria = models.CharField(max_length=200)
    bobot = models.FloatField()
    tipe_kriteria = models.CharField(max_length=10, choices=[('benefit', 'Benefit'), ('cost', 'Cost')])

    def __str__(self):
        return self.nama_kriteria

class Nilai(models.Model):
    pesanan = models.ForeignKey(Pesanan, on_delete=models.CASCADE)
    kriteria = models.ForeignKey(Kriteria, on_delete=models.CASCADE)
    nilai = models.FloatField()

    def __str__(self):
        return f"{self.pesanan} - {self.kriteria.nama_kriteria}"
