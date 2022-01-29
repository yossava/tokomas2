-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Karyawan" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "nama" TEXT NOT NULL,
    "alamat" TEXT NOT NULL,
    "password" TEXT NOT NULL DEFAULT '',
    "bagian" TEXT NOT NULL DEFAULT '',
    "gaji" TEXT NOT NULL DEFAULT '',
    "pph" TEXT NOT NULL DEFAULT '',
    "potongan_gaji" TEXT NOT NULL DEFAULT '',
    "tanggal_masuk" TEXT NOT NULL,
    "tanggal_keluar" TEXT NOT NULL DEFAULT '',
    "jenis_hutang" TEXT NOT NULL DEFAULT '',
    "jenis_barang_hutang" TEXT NOT NULL DEFAULT '',
    "jumlah_hutang" TEXT NOT NULL DEFAULT '',
    "nominal_cicilan" TEXT NOT NULL DEFAULT '',
    "lama_cicilan" TEXT NOT NULL DEFAULT '',
    "sisa_hutang" TEXT NOT NULL DEFAULT '',
    "nominal_uang_hutang" TEXT NOT NULL DEFAULT '',
    "jenis_barang_other" TEXT NOT NULL DEFAULT ''
);
INSERT INTO "new_Karyawan" ("alamat", "bagian", "createdAt", "gaji", "id", "jenis_barang_hutang", "jenis_hutang", "jumlah_hutang", "lama_cicilan", "nama", "nominal_cicilan", "password", "potongan_gaji", "pph", "sisa_hutang", "tanggal_keluar", "tanggal_masuk") SELECT "alamat", "bagian", "createdAt", "gaji", "id", "jenis_barang_hutang", "jenis_hutang", "jumlah_hutang", "lama_cicilan", "nama", "nominal_cicilan", "password", "potongan_gaji", "pph", "sisa_hutang", "tanggal_keluar", "tanggal_masuk" FROM "Karyawan";
DROP TABLE "Karyawan";
ALTER TABLE "new_Karyawan" RENAME TO "Karyawan";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
