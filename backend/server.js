const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Endpoint utama buat ngetes server
app.get('/', (req, res) => {
    res.json({
        status: 'success',
        message: 'API Ojek Online Backend is running smoothly!'
    });
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
