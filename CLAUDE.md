# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project: Kangaroo
Management system for inventory and operations.

## Core Architecture
- **Monolithic Web App**: Main logic and UI reside in `kangaroo_v6.1.html`.
- **Desktop Wrapper**: Tauri framework used to convert the web app into a Windows `.exe`.
- **Storage**: Uses `localStorage` with prefix `kng3_` (with a migration manager to prevent data loss during web-to-desktop transition).
- **Dependencies**: Chart.js, SheetJS (XLSX), jsPDF.
- **Backend**: Integration with Supabase.

## Development Commands
- **Build Desktop App**: `npx tauri build` (Generates the `.exe` and `.msi` in `src-tauri/target/release/bundle`)
- **Run in Dev Mode**: `npx tauri dev` (Launches the app window with hot-reload)
- **Tauri CLI Setup**: `npm install @tauri-apps/cli`

## Critical Guidelines
**Refer to `AGENTS.md` for the full "Wilander Development Operating System" rules.**
- **Stability Over All**: Do not rewrite functional code.
- **Minimal Changes**: Apply the smallest fix possible.
- **No Regressions**: Verify all dependencies (Dashboard, Inventory, etc.) before modifying core functions like `saveProduct`.
- **Data Integrity**: Any change to storage mechanisms must be preceded by a safety snapshot via `MigrationManager`.

## Key Modules
- Inventory, Providers, Dispatch (Despacho), Returns (Devoluciones), Movements, Calendar, and Settings.
