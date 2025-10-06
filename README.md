# 📦 Invoice App

[![CI Pipeline](https://github.com/antimasingh070/invoice_app/actions/workflows/ci.yml/badge.svg)](https://github.com/antimasingh070/invoice_app/actions)
[![Codecov](https://codecov.io/gh/antimasingh070/invoice_app/branch/main/graph/badge.svg?token=76b4d3e9-fab8-4d5f-82c6-5f5a7c80129f)](https://codecov.io/gh/antimasingh070/invoice_app)



A simple Ruby on Rails 7 application that manages **Invoices** and **Payments**.  
Each invoice can have multiple payments and supports **partial payments**.  
All monetary values are stored internally in **pennies (integer)** but displayed in **dollars** for user-facing operations.

---

## 🧠 Refactoring Decisions & Improvements

### ✅ Improved readability & Ruby idioms
- Used clear, intention-revealing method names like `fully_paid?` and `amount_owed`.
- Used **guard clauses** and **symbolic constants** (`Payment::METHODS`) for better clarity and maintainability.

### 🧩 Removed hidden logic traps
- Originally, the conversion from dollars to cents could cause confusion.  
  Added a clear callback `before_validation` (only on create) to prevent double conversion.

### ⚠️ Handled errors gracefully
- Wrapped `payments.create!` in a `rescue` block to log validation failures with `Rails.logger.error`.
- Raised meaningful `ArgumentError` messages for invalid payment methods or negative amounts.

### 🛠️ Improved maintainability
- Used `.clamp(0, Float::INFINITY)` to avoid negative balances in `amount_owed`.
- Centralized all currency conversion logic inside `convert_total_to_cents`.

### 💎 Made it more Ruby-like
- Used expressive numeric operations (`/ 100.0`) instead of integer math.
- Followed standard Ruby style conventions (two spaces, predicate methods ending with `?`, frozen constants).

---

## ⚙️ Tech Stack

| Category   | Technology     |
|-------------|----------------|
| **Language** | Ruby 3.2 |
| **Framework** | Rails 7.x |
| **Database** | PostgreSQL |
| **Testing** | RSpec |
| **CI/CD** | GitHub Actions |

---

## 🧪 Testing & Coverage

- All model logic is covered by **RSpec unit tests**.  
- Code coverage is measured with **SimpleCov** and visualized via **Codecov badge**.

Run tests locally:
```bash
bundle exec rspec
