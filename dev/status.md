# Project Status

> **IMPORTANT**: This file is loaded at the start of every Claude Code session.
> Keep it accurate. Update it before ending any session.
> This is the single source of truth for project state.

---

## Business Goal

Desktop tray-приложение для транскрибации голосовых заметок через OpenRouter (Gemini Flash), упакованное в .exe для личного использования.

---

## Current Phase

- [x] Phase 0: Intake & Requirements
- [ ] Phase 1: Design Document
- [x] Phase 2: Environment Setup
- [x] Phase 3: Development Loop (v0.3.0, повреждён)
- [ ] Phase 4: API Layer & Testing
- [ ] Phase 5: CI/CD
- [ ] Phase 6: Deploy

**Active phase**: Phase 1 — Fix CI + тестовая инфраструктура

---

## Backlog

Tasks in priority order. Check off when done.

- [ ] Phase 1: исправить CI — убрать `src/`, правильные пути для плоской структуры
- [ ] Phase 1: добавить ruff, mypy, pytest в pyproject.toml dev deps
- [ ] Phase 1: добавить pre-commit конфиг (ruff + mypy)
- [ ] Phase 2: написать тесты — unit (transcriber._parse_response, storage) + integration (FastAPI endpoints)
- [ ] Phase 3: архитектурные правки — HOST/PORT из config, startup валидация API key, __init__.py
- [ ] Phase 4: UI/UX улучшения (обсудить отдельно)

**Completed (most recent first):**
- [x] Phase 0: cleanup — удалены битые артефакты, зафиксированы .github/ и dev/ — e67691b — 2026-03-06
- [x] feat: v0.3.0 — tray app, pywebview, retry logic, save failed audio — 858d1a7

---

## Known Issues and Solutions

### P0-проблемы из аудита (требуют fix в Phase 1)

**CI сломан**: `ci.yml` запускает `mypy src/` и `pytest --cov=src` — папки `src/` нет, структура плоская.
**Нет dev-зависимостей**: `pyproject.toml` dev group содержит только `pyinstaller`. Нет ruff, mypy, pytest.

### P1-проблемы (Phase 3)

- `HOST = "0.0.0.0"` в config.py — должен быть `127.0.0.1` для desktop app
- `PORT` дублируется в `tray.py` без импорта из `config.py`
- Нет валидации `OPENROUTER_API_KEY` при старте приложения

---

## Architecture Decisions

| Decision | Choice | Date |
|---|---|---|
| Web framework | FastAPI + uvicorn | initial |
| UI | PyWebView (embedded browser window) + Jinja2 templates | initial |
| Transcription | OpenRouter API (Gemini Flash) | initial |
| Storage | SQLite via aiosqlite | initial |
| Packaging | PyInstaller → .exe | initial |
| Tray | pystray + pillow | initial |

---

## Next Session Plan

1. Fix CI: исправить `ci.yml` под плоскую структуру (без `src/`)
2. Добавить ruff + mypy + pytest в `pyproject.toml` dev deps
3. Настроить pre-commit
4. Написать первые unit-тесты для `transcriber._parse_response`

---

## Files to Know

| File | Purpose |
|------|---------|
| `main.py` | Entry point: запускает FastAPI + uvicorn + tray |
| `config.py` | Конфигурация: API keys, пути, настройки |
| `paths.py` | Резолвинг путей (особенно для PyInstaller) |
| `services/` | Бизнес-логика: transcription, storage |
| `templates/` | Jinja2 HTML-шаблоны для PyWebView |
| `tray.py` | Системный трей (pystray) |
| `build.py` | PyInstaller build script |
| `dist/` | Готовые .exe — НЕ УДАЛЯТЬ |

---

*Last updated: 2026-03-06 by Claude Code*
