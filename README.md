# 🧪 Periodic Table Database  

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Project%20Status-Completed-blue?style=for-the-badge)

---

## 🚀 Overview  

This project is a **PostgreSQL-based database** for managing information about **chemical elements**, inspired by the periodic table.  
It was created as a practice project to learn **SQL relationships**, **data normalization**, and **Bash scripting** for command-line database interaction.  

The Bash script `element.sh` allows users to retrieve structured element data — such as atomic number, name, type, mass, and physical properties.

---

## 🗂️ Database Structure  

The database consists of three core tables:

- **`elements`** – Stores element identifiers (atomic number, name, symbol).  
- **`properties`** – Holds physical properties like atomic mass, melting point, and boiling point.  
- **`types`** – Defines element categories (metal, nonmetal, metalloid).  

---

## 🔗 Relationships  

- `elements.atomic_number` → `properties.atomic_number` (one-to-one)  
- `types.type_id` → `properties.type_id` (one-to-many)  

---

## ⚙️ Installation  

Clone the repository:
```bash
git clone https://github.com/<your-username>/periodic_table.git
cd periodic_table
Import the database schema and sample data:

bash
Копіювати код
psql -U <your-username> -d periodic_table -f periodic_table.sql
🧰 Usage
Run the script to query information about an element:

bash
Копіювати код
./element.sh
Behavior:
No argument →
Please provide an element as an argument.

Valid element (by number, symbol, or name) →
The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.

Invalid element →
I could not find that element in the database.

## 📁 Files
File	Description
periodic_table.sql	Database schema and initial data
element.sh	Bash script to fetch and display element information
README.md	Project documentation

## 🧠 Learning Objectives
Practice database normalization and foreign key relationships

Execute SQL joins and filters

Use Bash scripting to query PostgreSQL

Apply text formatting with sed, psql flags, and structured output

## 🧻 License
This project is released under the MIT License.
You’re free to use, modify, and distribute it for personal or educational purposes.