# PowerShell File Integrity Monitor (FIM)

## 🛡️ Project Overview
This project is a functional **File Integrity Monitor (FIM)** developed in PowerShell. It allows users to create a "gold standard" baseline of a directory and monitor it in real-time for any unauthorized changes, deletions, or new file creations. This tool demonstrates core security concepts including **Hashing (SHA512)** and **Data Integrity**.


## ✨ Key Features
* **Baseline Generation:** Scans a target folder and generates unique SHA512 hashes for every file.
* **Real-Time Monitoring:** Continuous loop that checks for changes every second.
* **State Management:** Uses a Dictionary (Hash Table) to store file states and prevent "alert fatigue."
* **Color-Coded Visual Alerts:**
    * 🟢 **Green:** New file detected.
    * 🟡 **Yellow:** File content has been modified.
    * 🔴 **Red:** File has been deleted.

## ⚙️ How It Works
1.  **Option A (Baseline):** The script iterates through the `.\Files` directory, calculates a digital fingerprint (hash) for each file, and saves it to `baseline.txt`.
2.  **Option B (Monitor):** The script loads the baseline into memory and enters a loop. It compares the *current* state of the folder against the *saved* baseline. If a hash doesn't match or a file is missing, it triggers an alert.

## 🛠️ Usage
1. Place the files you want to monitor in a folder named `Files` in the same directory as the script.
2. Run the script: `.\FIM.ps1`
3. Choose **Option A** to set your "Perfect State."
4. Choose **Option B** to begin live monitoring.

## 🧠 Skills Demonstrated
* **Automation:** Using PowerShell for security task automation.
* **Cryptography:** Implementation of SHA512 hashing for integrity verification.
* **Error Handling:** Managing file access issues during live monitoring.
