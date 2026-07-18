# ProCode - Vanilla JS Version

This is a vanilla JavaScript, HTML, CSS, and Tailwind CSS version of the ProCode learning application.

## 🚀 Quick Start

### 1. Configure Supabase

Edit `public/config.js` and add your Supabase credentials:

```javascript
window.VITE_SUPABASE_URL = 'https://your-project.supabase.co';
window.VITE_SUPABASE_PUBLISHABLE_KEY = 'your-anon-key-here';
```

You can find these credentials in your [Supabase Dashboard](https://supabase.com/dashboard) under:
- Project Settings → API → Project URL
- Project Settings → API → Project API keys (anon/public)

### 2. Serve the Files

You can use any static file server. Here are a few options:

**Option A: Python HTTP Server**
```bash
cd public
python -m http.server 8080
```

**Option B: Node.js http-server**
```bash
npm install -g http-server
cd public
http-server -p 8080
```

**Option C: VS Code Live Server**
- Install the "Live Server" extension
- Right-click `public/index.html` → "Open with Live Server"

### 3. Open in Browser

Navigate to `http://localhost:8080` (or the port your server is using)

## 📁 File Structure

```
public/
├── index.html          # Landing page
├── login.html          # Login page
├── signup.html         # Signup page
├── learn.html          # Main learning dashboard (protected)
├── config.js           # Supabase configuration
├── auth.js             # Authentication manager
├── mascot.png          # ProCode mascot image (copy from src/assets/)
└── hero-bg.png         # Hero background image (copy from src/assets/)
```

## 🔧 Features

- ✅ Email/Password authentication via Supabase
- ✅ Protected routes (learn page requires authentication)
- ✅ Responsive design with Tailwind CSS
- ✅ Loading states and error handling
- ✅ Session persistence

## 🔐 Authentication

The app uses Supabase for authentication. The Google OAuth button is hidden by default because it requires additional setup:

### To Enable Google OAuth:

1. Go to your Supabase Dashboard
2. Navigate to Authentication → Providers
3. Enable Google OAuth provider
4. Add your Google OAuth credentials
5. Configure the redirect URL
6. Uncomment the Google button in `login.html` and `signup.html` by removing the `hidden` class

## 🎨 Customization

### Colors

The Tailwind config in each HTML file defines the color scheme. Key colors:
- Primary: `hsl(25, 100%, 50%)` (orange)
- Background: `hsl(0, 0%, 100%)` (white)
- Foreground: `hsl(222.2, 84%, 4.9%)` (dark blue)

### Images

Replace these placeholder images with your actual assets:
- `mascot.png` - The ProCode mascot
- `hero-bg.png` - Hero section background

## 🐛 Troubleshooting

### "Supabase credentials not configured"
- Make sure you've edited `config.js` with your actual Supabase URL and key

### OAuth Error (400)
- Google OAuth requires setup in Supabase dashboard
- Use email/password authentication instead, or complete the OAuth setup

### Pages not loading
- Make sure you're serving from the `public` directory
- Check browser console for errors

## 📝 Next Steps

This is a basic vanilla JS implementation. To add full functionality:

1. Connect to your Supabase database tables (lessons, progress, etc.)
2. Implement lesson content display
3. Add quiz/challenge functionality
4. Build progress tracking
5. Add leaderboard features

## 🔗 Related Files

The original React application files are still in the `src/` directory if you need reference.

## 📄 License

© 2026 ProCode. All rights reserved.
