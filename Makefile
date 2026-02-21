# Detect OS
ifeq ($(OS),Windows_NT)
  PLATFORM := windows
  OPEN_CMD := start
  UV_RUN := uv run python
  UV_RUN_W := uv run pythonw
  NOHUP :=
else
  PLATFORM := unix
  OPEN_CMD := xdg-open 2>/dev/null || open
  UV_RUN := uv run python
  UV_RUN_W := uv run python
  NOHUP := nohup
endif

PORT ?= $(shell grep "^PORT=" .env 2>/dev/null | cut -d= -f2 || echo 8000)

.PHONY: help setup install run dev tray tray-bg clean

help:
	@echo ""
	@echo "  Voice Transcriber"
	@echo "  ========================================"
	@echo "  make setup      First-time setup"
	@echo "  make install    Install dependencies"
	@echo "  make run        Web mode (browser)"
	@echo "  make dev        Web mode with hot-reload"
	@echo "  make tray       Tray mode (foreground)"
	@echo "  make tray-bg    Tray mode (background)"
	@echo "  make clean      Remove Python cache"
	@echo ""

setup:
	@uv --version > /dev/null 2>&1 || (echo "ERROR: uv not found. Install: https://docs.astral.sh/uv/getting-started/installation/" && exit 1)
ifeq ($(PLATFORM),windows)
	@if not exist .env (copy .env.example .env && echo "Created .env - add your OPENROUTER_API_KEY") else (echo ".env already exists")
else
	@[ -f .env ] || (cp .env.example .env && echo "Created .env - add your OPENROUTER_API_KEY")
endif
	uv sync
	@echo "Setup complete. Edit .env then run: make tray"

install:
	uv sync

run:
	$(UV_RUN) main.py

dev:
	uv run uvicorn main:app --reload --host 0.0.0.0 --port $(PORT)

tray:
	$(UV_RUN) tray.py

tray-bg:
ifeq ($(PLATFORM),windows)
	@echo "Use start.vbs for background tray on Windows"
else
	$(NOHUP) $(UV_RUN) tray.py > /tmp/vt-tray.log 2>&1 &
	@echo "Started in background. Logs: /tmp/vt-tray.log"
endif

clean:
ifeq ($(PLATFORM),windows)
	@for /d /r . %%d in (__pycache__) do @if exist "%%d" rd /s /q "%%d"
else
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -name "*.pyc" -delete 2>/dev/null || true
endif

build:
	uv run python build.py
	@echo ""
	@echo "Executable ready in dist/"
