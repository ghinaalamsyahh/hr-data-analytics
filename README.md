1. Problem (Permasalahan)
Manajemen dan departemen Human Resources (HR) sering kali menghadapi tantangan strategis terkait pengelolaan talenta, seperti tingginya tingkat keluar-masuk karyawan (turnover/attrition), kesenjangan kompensasi (pay gap), serta ketidakmerataan distribusi beban kerja atau evaluasi kinerja di berbagai departemen. Tanpa analisis berbasis data (data-driven), perusahaan akan kesulitan untuk:
- Mengidentifikasi departemen atau tingkat jabatan (job level) mana yang memiliki risiko attrition (turnover) tertinggi.
- Menilai apakah kompensasi/gaji sudah adil dan selaras dengan performance rating serta gender/demografi.
- Melacak profil karyawan berprestasi tinggi (high performers) yang berpotensi flight risk (cenderung resign karena kurangnya apresiasi atau promosi).

2. Data (Sumber & Struktur Data)
Dataset ini bersumber dari Website Kaggle: https://www.kaggle.com/datasets/rohyem55/companies-and-employees-hr-dataset. Dataset employees.csv terdiri dari 3.000 row data dan 17 kolom, sedangkan dataset companies.csv memiliki 60 row data dan 7 kolom. Di mana kedua dataset ini digabungkan dengan RIGHT JOIN (employees.csv berada di kanan), sehingga total data tetap 3.000 row dan menjadi sebanyak 23 kolom. Terdapat kolom-kolom yang mengandung nilai null, yaitu performance_rating, job_satisfaction, and overtime_hours_month. Hal ini kemudian diatasi dengan pengisian semua data null tersebut dengan menghitung dan menginput rata-rata nilai di setiap kolomnya menggunakan Power BI.
Analisis ini menggunakan dua tabel utama dari dataset Companies and Employees / HR Dataset yang digabungkan (right join) berdasarkan company_id:
- Tabel employees: Berisi 3.000 data karyawan mencakup informasi demografi (usia, jenis kelamin, tingkat pendidikan), detail pekerjaan (departemen, job level, lama pengalaman, tanggal bergabung), kompensasi (gaji bulanan dalam EGP), metrik kinerja (performance rating, job satisfaction), dan status keaktifan (left_company).
- Tabel companies: Berisi informasi profil perusahaan seperti nama perusahaan, industri, kota lokasi kantor, tahun berdiri, skala perusahaan, dan kebijakan kerja jarak jauh (remote policy).
- Tabel employees_full: Berisi informasi hasil dari LEFT JOIN dari tabel companies ke tabel employees, sehingga merupakan perpaduan dari kedua tabel tersebut.

3. Approach (Pendekatan Analisis SQL)
Eksplorasi data dilakukan menggunakan SQL melalui beberapa tahapan analisis utama:
- Analisis Demografi & Distribusi (Descriptive Analytics): Menggunakan fungsi agregasi (COUNT, AVG, GROUP BY) dan pengelompokan kondisi (CASE WHEN) untuk memetakan total headcount, rasio gender per departemen, kelompok usia, dan konsentrasi karyawan berdasarkan lokasi kota.
- Analisis Kompensasi & Gaji (Financial Analytics): Menganalisis rentang gaji (min, max, avg) berdasarkan departemen dan job level, serta mengevaluasi potensi disparitas gaji berdasarkan gender serta korelasi antara performance rating dan kompensasi.
- Analisis Retensi & Attrition (Predictive/Risk Analytics): Memanfaatkan Common Table Expressions (WITH CTE) untuk menghitung persentase tingkat attrition per departemen dan job level, durasi masa kerja rata-rata sebelum karyawan resign (tenure at exit), serta mengidentifikasi high performers dengan masa kerja >3 tahun yang belum mengalami promosi (flight risk analysis). 

4. Hasil
- Tingkat Attrition Keseluruhan: Angka turnover perusahaan berada di kisaran 15,27% dari total 3.000 karyawan. Departemen Finance mencatat tingkat attrition tertinggi (sekitar 18,09%), diikuti oleh Operations (16,70%) dan Sales (15,32%). Level pekerjaan yang memiliki turnover tertinggi ini juga berasal dari tingkat Junior untuk ketiga departemen.
- Masa Kerja Kritis (Critical Cliff): Rata-rata masa kerja karyawan yang resign adalah 3,75 tahun (sementara rata-rata keseluruhan masa kerja karyawan aktif adalah 4,62 tahun). Hal ini menunjukkan adanya titik jenuh atau minimnya jalur karier di sekitar tahun ke-3 hingga ke-4.
- Kompensasi & Kinerja: Analisis menunjukkan bahwa rata-rata gaji bulanan perusahaan berada di angka 19.900 EGP. Evaluasi silang antara performance rating dan gaji menunjukkan perlunya peninjauan mendalam pada kelompok outliers, di mana beberapa karyawan dengan performa tinggi mungkin menerima kompensasi di bawah rata-rata departemen.
- Identifikasi Flight Risk: Kueri SQL berhasil memetakan daftar karyawan top-performer dengan masa kerja di atas 3 tahun pada level non-manajerial yang belum mendapatkan promosi, sehingga dapat segera ditindaklanjuti oleh tim HR.   

5. Rekomendasi Bisnis
Hasil dari analisis SQL ini memberikan dampak strategis bagi operasional HR dan manajemen perusahaan:
- Mitigasi Risiko Turnover (Retensi Proaktif): Dengan mengetahui bahwa departemen Finance dan Operations memiliki tingkat attrition tertinggi, manajemen dapat merancang program retensi yang ditargetkan khusus, seperti peninjauan benefit atau fleksibilitas kerja.
- Intervensi Jalur Karier (Career Pathing): Temuan terkait karyawan berprestasi dengan masa kerja >3 tahun tanpa promosi memungkinkan HR untuk segera memberikan penawaran pengembangan karier atau salary adjustment guna mencegah brain drain (kehilangan talenta kunci).
- Keadilan Kompensasi (Pay Equity): Audit gaji berbasis job level dan performance rating membantu perusahaan memastikan struktur penggajian yang kompetitif, transparan, dan adil untuk mengurangi ketidakpuasan internal.

6. Tools
Adapun alat/software yang dipakai dalam proyek ini adalah SQL sebagai bahasa pemrogramannya dan dijalankan di platform data BigQuery serta Power BI.
