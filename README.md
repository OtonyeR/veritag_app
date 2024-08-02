<!DOCTYPE html>
<html>
<head>
  <title>VeriTag App</title>
</head>
<body>

<h1>VeriTag App</h1>

<p>VeriTag is a mobile application developed using Flutter that leverages NFC technology to ensure product authenticity and track product journeys through the supply chain. The app allows manufacturers, distributors, and consumers to scan NFC tags attached to products, providing real-time information about the product's origin, journey, and authenticity.</p>

<h2>Table of Contents</h2>
<ul>
  <li><a href="#features">Features</a></li>
  <li><a href="#architecture">Architecture</a></li>
  <li><a href="#installation">Installation</a></li>
  <li><a href="#usage">Usage</a></li>
  <li><a href="#project-structure">Project Structure</a></li>
  <li><a href="#contributing">Contributing</a></li>
  <li><a href="#license">License</a></li>
  <li><a href="#contact">Contact</a></li>
</ul>

<h2 id="features">Features</h2>
<ul>
  <li><strong>NFC Tag Scanning</strong>: Scan NFC tags to retrieve product information and status.</li>
  <li><strong>Product Verification</strong>: Verify the authenticity of products and view their journey through the supply chain.</li>
  <li><strong>Data Input & Management</strong>: Manufacturers and other stakeholders can input and update product information.</li>
  <li><strong>User Roles & Access Control</strong>: Different access levels for manufacturers and consumers.</li>
  <li><strong>Secure Data Handling</strong>: Data encryption and secure authentication protocols ensure the safety of user and product information.</li>
</ul>

<h2 id="architecture">Architecture</h2>
<h3>Frontend</h3>
<ul>
  <li><strong>Framework</strong>: Flutter</li>
  <li><strong>State Management</strong>: Stateful Widgets</li>
  <li><strong>Core Packages</strong>: nfc_manager, image_picker</li>
</ul>

<h3>Backend</h3>
<ul>
  <li><strong>Database</strong>: Firestore </li>
</ul>

<h2 id="installation">Installation</h2>
<h3>Prerequisites</h3>
<ul>
  <li>Flutter SDK</li>
  <li>Dart</li>
</ul>

<h3>Steps</h3>
<ol>
  <li>
    <strong>Clone the repository</strong>:
    <pre>
      <code>
        git clone https://github.com/OtonyeR/veritag.git
        cd veritag
      </code>
    </pre>
  </li>
  <li>
    <strong>Install dependencies</strong>:
    <pre>
      <code>
        flutter pub get
      </code>
    </pre>
  </li>
  <li>
    <strong>Configure environment variables</strong>:
    <p>Create a <code>.env</code> file in the root directory and add necessary API keys and environment-specific settings.</p>
  </li>
  <li>
    <strong>Run the app</strong>:
    <pre>
      <code>
        flutter run
      </code>
    </pre>
  </li>
</ol>

<h2 id="usage">Usage</h2>
<ol>
  <li><strong>Scanning NFC Tags</strong>: Use the app to scan NFC tags attached to products to view information and verify authenticity.</li>
  <li><strong>Inputting Data</strong>: Manufacturers can enter product details.</li>
  <li><strong>Viewing Product History</strong>: Check the journey and status of products through the supply chain.</li>
</ol>

<h2 id="project-structure">Project Structure</h2>
<pre>
<code>
veritag/
│
├── lib/
│   ├── models/         # Data models and classes
│   ├── services/       # Services for API calls, NFC interactions
│   ├── views/          # UI screens
│   ├── widgets/        # Reusable UI components
│   ├── utils/          # Utility functions and helpers
│   └── main.dart       # Entry point of the app
│
├── assets/             # Images, icons, fonts, etc.
└── README.md           # This file
</code>
</pre>

<h2 id="app-screenshots">App Screenshots</h2>
<p><img src="https://github.com/OtonyeR/veritag_app/tree/main/screenshots/6%20Manufacturer%20home.jpg" alt="Manufacturer Home" /></p>
<p><img src="https://github.com/OtonyeR/veritag_app/tree/main/screenshots/7%20Manufacturer%20form.jpg" alt="Manufacturer Form" /></p>
<p><img src="https://github.com/OtonyeR/veritag_app/tree/main/screenshots/12%20read%20complete.jpg" alt="Read Complete" /></p>
<p><img src="https://github.com/OtonyeR/veritag_app/tree/main/screenshots/13%20Authentic%20Product.jpg" alt="Authentic Product" /></p>

<h2>APK DOWNLOAD LINK</h2>
<p><a href="https://drive.google.com/file/d/1BtWZ6DAYDplIQgf1GUdIJ-Jgaa4JKbCz/view?usp=sharing">Download APK</a></p>

<h2 id="contributing">Contributing</h2>
<p>We welcome contributions from the community! Please follow these steps to contribute:</p>
<ol>
  <li>Fork the repository.</li>
  <li>Create a new branch for your feature or bugfix.</li>
  <li>Commit your changes with clear commit messages.</li>
  <li>Push your changes to your fork.</li>
  <li>Submit a pull request with a description of your changes.</li>
</ol>

<h2 id="license">License</h2>
<p>This project is licensed under the MIT License - see the <a href="LICENSE">LICENSE</a> file for details.</p>

</body>
</html>
