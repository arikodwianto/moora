from django.urls import path
from . import views

urlpatterns = [
    path("login/", views.login_view, name="login"),
    path("logout/", views.logout_view, name="logout"),
    path("profile/", views.profile_view, name="profile"),
    path("add-admin/", views.add_admin_view, name="add_admin"),
    path("dashboard/", views.profile_view, name="dashboard"),  # sementara pakai
    path("admin/dashboard/", views.admin_dashboard, name="admin_dashboard"),
    path("admins/", views.list_admin_view, name="list_admin"),
    path("admins/<int:user_id>/edit/", views.edit_admin_view, name="edit_admin"),
    path("admins/<int:user_id>/delete/", views.delete_admin_view, name="delete_admin"),
    
    path('', views.dashboard, name='dashboard'),
    # Pelanggan
    path('pelanggan/', views.list_pelanggan, name='list_pelanggan'),
    path('pelanggan/tambah/', views.tambah_pelanggan, name='tambah_pelanggan'),
    path('pelanggan/ubah/<int:id>/', views.ubah_pelanggan, name='ubah_pelanggan'),
    path('pelanggan/hapus/<int:id>/', views.hapus_pelanggan, name='hapus_pelanggan'),

    # Pesanan
    path('pesanan/', views.list_pesanan, name='list_pesanan'),
    path('pesanan/tambah/', views.tambah_pesanan, name='tambah_pesanan'),
    path('pesanan/ubah/<int:id>/', views.ubah_pesanan, name='ubah_pesanan'),
    path('pesanan/hapus/<int:id>/', views.hapus_pesanan, name='hapus_pesanan'),
    path('pesanan/selesai/<int:id>/', views.selesai_pesanan, name='selesai_pesanan'),

    # Kriteria
    path('kriteria/', views.list_kriteria, name='list_kriteria'),
    path('kriteria/tambah/', views.tambah_kriteria, name='tambah_kriteria'),
    path('kriteria/ubah/<int:id>/', views.ubah_kriteria, name='ubah_kriteria'),
    path('kriteria/hapus/<int:id>/', views.hapus_kriteria, name='hapus_kriteria'),

    # Nilai
    path('nilai/', views.list_nilai, name='list_nilai'),
    path('nilai/tambah/', views.tambah_nilai, name='tambah_nilai'),
    path('nilai/ubah/<int:id>/', views.ubah_nilai, name='ubah_nilai'),
    path('nilai/hapus/<int:id>/', views.hapus_nilai, name='hapus_nilai'),

    # Hasil MOORA
    path('hasil/', views.hasil_moora, name='hasil_moora'),
    # URL hasil moora biasa
    path('hasil-moora/', views.hasil_moora, name='hasil_moora'),
    # URL untuk cetak PDF
    path('hasil-moora/cetak-pdf/', views.cetak_hasil_moora_pdf, name='cetak_hasil_moora_pdf'),

    path('laporan-pesanan-bulanan/', views.laporan_pesanan_bulanan, name='laporan_pesanan_bulanan'),
    path('laporan-pesanan-bulanan/cetak/', views.cetak_laporan_pesanan_bulanan, name='cetak_laporan_pesanan_bulanan'),
    

]
