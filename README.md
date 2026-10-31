1. Problem (Permasalahan)
Manajemen dan departemen Human Resources (HR) sering kali menghadapi tantangan strategis terkait pengelolaan talenta, seperti tingginya tingkat keluar-masuk karyawan (turnover/attrition), kesenjangan kompensasi (pay gap), serta ketidakmerataan distribusi beban kerja atau evaluasi kinerja di berbagai departemen. Tanpa analisis berbasis data (data-driven), perusahaan akan kesulitan untuk:
- Mengidentifikasi departemen atau tingkat jabatan (job level) mana yang memiliki risiko attrition (turnover) tertinggi.
- Menilai apakah kompensasi/gaji sudah adil dan selaras dengan performance rating serta gender/demografi.
- Melacak profil karyawan berprestasi tinggi (high performers) yang berpotensi flight risk (cenderung resign karena kurangnya apresiasi atau promosi).

2. Data (Sumber & Struktur Data)
Analisis ini menggunakan dua tabel utama dari dataset Companies and Employees / HR Dataset yang digabungkan (right join) berdasarkan company_id:
- Tabel employees: Berisi 3.000 data karyawan mencakup informasi demografi (usia, jenis kelamin, tingkat pendidikan), detail pekerjaan (departemen, job level, lama pengalaman, tanggal bergabung), kompensasi (gaji bulanan dalam EGP), metrik kinerja (performance rating, job satisfaction), dan status keaktifan (left_company).
- Tabel companies: Berisi informasi profil perusahaan seperti nama perusahaan, industri, kota lokasi kantor, tahun berdiri, skala perusahaan, dan kebijakan kerja jarak jauh (remote policy).
- Tabel employees_full: Berisi informasi hasil dari LEFT JOIN dari tabel companies ke tabel employees, sehingga merupakan perpaduan dari kedua tabel tersebut.

3. Approach (Pendekatan Analisis SQL)
Eksplorasi data dilakukan menggunakan SQL melalui beberapa tahapan analisis utama:
- Analisis Demografi & Distribusi (Descriptive Analytics): Menggunakan fungsi agregasi (COUNT, AVG, GROUP BY) dan pengelompokan kondisi (CASE WHEN) untuk memetakan total headcount, rasio gender per departemen, kelompok usia, dan konsentrasi karyawan berdasarkan lokasi kota.
- Analisis Kompensasi & Gaji (Financial Analytics): Menganalisis rentang gaji (min, max, avg) berdasarkan departemen dan job level, serta mengevaluasi potensi disparitas gaji berdasarkan gender serta korelasi antara performance rating dan kompensasi.
- Analisis Retensi & Attrition (Predictive/Risk Analytics): Memanfaatkan Common Table Expressions (WITH CTE) untuk menghitung persentase tingkat attrition per departemen dan job level, durasi masa kerja rata-rata sebelum karyawan resign (tenure at exit), serta mengidentifikasi high performers dengan masa kerja >3 tahun yang belum mengalami promosi (flight risk analysis). 


4. Impact (Dampak & Rekomendasi Bisnis)
Hasil dari analisis SQL ini memberikan dampak strategis bagi operasional HR dan manajemen perusahaan:
- Mitigasi Risiko Turnover (Retensi Proaktif): Dengan mengetahui bahwa departemen Finance dan Operations memiliki tingkat attrition tertinggi, manajemen dapat merancang program retensi yang ditargetkan khusus, seperti peninjauan benefit atau fleksibilitas kerja.
- Intervensi Jalur Karier (Career Pathing): Temuan terkait karyawan berprestasi dengan masa kerja >3 tahun tanpa promosi memungkinkan HR untuk segera memberikan penawaran pengembangan karier atau salary adjustment guna mencegah brain drain (kehilangan talenta kunci).
- Keadilan Kompensasi (Pay Equity): Audit gaji berbasis job level dan performance rating membantu perusahaan memastikan struktur penggajian yang kompetitif, transparan, dan adil untuk mengurangi ketidakpuasan internal.

5. Tools
Adapun alat/software yang dipakai dalam proyek ini adalah SQL sebagai bahasa pemrogramannya dan dijalankan di platform data BigQuery.
