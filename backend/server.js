const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

let users = [];
let orders = []; // Database sementara untuk order

app.get('/', (req, res) => res.json({ message: 'API Ojek Online Backend is running!' }));

// Register & Login (sama seperti sebelumnya)
app.post('/api/register', (req, res) => {
    const { name, phone, role } = req.body;
    const newUser = { id: Date.now().toString(), name, phone, role };
    users.push(newUser);
    res.status(201).json({ status: 'success', data: newUser });
});

// Endpoint Create Order
app.post('/api/order', (req, res) => {
    const { customerId, pickup, destination } = req.body;
    const newOrder = {
        orderId: Date.now().toString(),
        customerId,
        pickup,
        destination,
        status: 'searching' // status: searching, accepted, on-the-way, finished
    };
    orders.push(newOrder);
    res.status(201).json({ status: 'success', message: 'Order berhasil dibuat!', data: newOrder });
});

app.listen(PORT, () => console.log(`Server is running on port ${PORT}`));
