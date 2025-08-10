from django.db import models

class Pelanggan(models.Model):
    nama_pelanggan = models.CharField(max_length=200)
    alamat = models.TextField()
    no_hp = models.CharField(max_length=20)
    prioritas = models.IntegerField()

    def __str__(self):
        return self.nama_pelanggan

class Pesanan(models.Model):
    pelanggan = models.ForeignKey(Pelanggan, on_delete=models.CASCADE)
    tanggal_pesan = models.DateField()
    jumlah_galon = models.IntegerField()
    tanggal_pengiriman = models.DateField()

    def __str__(self):
        return f"Pesanan {self.id} - {self.pelanggan.nama_pelanggan}"

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
