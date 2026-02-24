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

**Active phase**: Phase 0 — Восстановление проекта и аудит

---

## Backlog

Tasks in priority order. Check off when done.

- [ ] Phase 0: аудит всех файлов — удалить битые артефакты, очистить `{services,templates,transcripts}` папку
- [ ] Phase 0: определить актуальную версию кода (v0.3.0, последний коммит `858d1a7`)
- [ ] Phase 1: создать design-doc.md на основе существующего кода
- [ ] Phase 4: добавить pytest, написать тесты (unit + integration)
- [ ] Phase 5: настроить GitHub Actions CI (minimal profile уже создан)
- [ ] Архитектурные улучшения UI/UX по результатам аудита

**Completed (most recent first):**
- [x] Deploy ml-claude-infra module — 2026-03-06
- [x] feat: v0.3.0 — tray app, pywebview, retry logic, save failed audio — 858d1a7

---

## Known Issues and Solutions

### Повреждённая папка `{services,templates,transcripts}`

**Problem**: В корне проекта есть папка с именем `{services,templates,transcripts}` — артефакт неудачного brace expansion в bash
**Root cause**: Вероятно, команда типа `mkdir {services,templates,transcripts}` выполнена в Windows cmd/PowerShell, где brace expansion не работает
**Solution**: Проверить содержимое, если пустая — удалить
**Date**: 2026-03-06

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

> Следующая сессия — восстановление и аудит проекта.

1. Прочитать все файлы проекта — оценить состояние кода
2. Удалить битые артефакты (`{services,templates,transcripts}` папка, `__pycache__`, etc.)
3. Ранжировать проблемы по критичности
4. Составить план доработок (design-doc.md)
5. Dist/ не трогать — там рабочие .exe

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
