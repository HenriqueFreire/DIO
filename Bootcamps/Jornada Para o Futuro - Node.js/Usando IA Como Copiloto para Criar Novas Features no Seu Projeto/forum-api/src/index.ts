import express from 'express';

const app = express();
const port = 3000;

app.use(express.json()); // Middleware for parsing JSON bodies

interface Post {
  id: string;
  title: string;
  content: string;
  author: string;
}

let posts: Post[] = [];
let postIdCounter = 1;

// Get all posts
app.get('/posts', (req, res) => {
  res.json(posts);
});

// Get a single post by ID
app.get('/posts/:id', (req, res) => {
  const post = posts.find(p => p.id === req.params.id);
  if (post) {
    res.json(post);
  } else {
    res.status(404).send('Post not found');
  }
});

// Create a new post
app.post('/posts', (req, res) => {
  const { title, content, author } = req.body;
  if (!title || !content || !author) {
    return res.status(400).send('Missing required fields: title, content, author');
  }
  const newPost: Post = {
    id: (postIdCounter++).toString(),
    title,
    content,
    author,
  };
  posts.push(newPost);
  res.status(201).json(newPost);
});

// Update an existing post
app.put('/posts/:id', (req, res) => {
  const { title, content, author } = req.body;
  const postIndex = posts.findIndex(p => p.id === req.params.id);

  if (postIndex !== -1) {
    posts[postIndex] = { ...posts[postIndex], title, content, author };
    res.json(posts[postIndex]);
  } else {
    res.status(404).send('Post not found');
  }
});

// Delete a post
app.delete('/posts/:id', (req, res) => {
  const initialLength = posts.length;
  posts = posts.filter(p => p.id !== req.params.id);
  if (posts.length < initialLength) {
    res.status(204).send(); // No Content
  } else {
    res.status(404).send('Post not found');
  }
});

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'UP' });
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
