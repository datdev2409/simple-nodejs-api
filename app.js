const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());

// Routes
app.get('/', (req, res) => {
  res.json({ message: 'Welcome to Simple Node.js API' });
});

app.get('/api/hello', (req, res) => {
  res.json({ message: 'Hello from Express API!' });
});

app.get('/api/users/:id', (req, res) => {
  const { id } = req.params;
  res.json({ 
    id,
    name: `User ${id}`,
    email: `user${id}@example.com`
  });
});

app.post('/api/users', (req, res) => {
  const { name, email } = req.body;
  res.status(201).json({ 
    id: 1,
    name,
    email,
    message: 'User created successfully'
  });
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({ error: 'Route not found' });
});

// Start server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
  console.log(`Health check: http://localhost:${PORT}/health`);
});
