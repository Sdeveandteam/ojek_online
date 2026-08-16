const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Database sementara (array di memori)
let users = [];

// Endpoint utama
app.get('/', (req, res) => {
    res.json({
        status: 'success',
        message: 'API Ojek Online Backend is running smoothly!'
    });
});

// Endpoint Register
app.post('/api/register', (req, res) => {
    const { name, phone, role } = req.body; // role: 'customer' atau 'driver'
    
    if (!name || !phone || !role) {
        return res.status(400).json({ status: 'error', message: 'Semua kolom wajib diisi!' });
    }

    // Cek apakah nomor HP sudah terdaftar
    const existingUser = users.find(u => u.phone === phone);
    if (existingUser) {
        return res.status(400).json({ status: 'error', message: 'Nomor telepon sudah terdaftar!' });
    }

    const newUser = { id: Date.now().toString(), name, phone, role };
    users.push(newUser);

    res.status(201).json({
        status: 'success',
        message: 'Registrasi berhasil!',
        data: newUser
    });
});

// Endpoint Login
app.post('/api/login', (req, res) => {
    const { phone } = req.body;

    const user = users.find(u => u.phone === phone);
    if (!user) {
        return res.status(404).json({ status: 'error', message: 'Nomor telepon tidak ditemukan!' });
    }

    res.json({
        status: 'success',
        message: 'Login berhasil!',
        data: user
    });
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
