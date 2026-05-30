---
globs: "app/models/**/*.rb"
---

# Model Conventions

When creating new models, always include:
- `audited` — for audit tracking
- `strip_attributes` — for whitespace stripping on string fields