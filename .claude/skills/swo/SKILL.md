---
name: swo
description: >-
  Query production logs from SolarWinds Observability (SWO) for a RadStack app. Use whenever the
  user asks to check, search, tail, or count production logs — e.g. "check the prod logs for X",
  "any errors in production?", "how many AutoRefillJobs ran today?", "tail the worker logs". Runs
  the `swo` CLI (a rad_common gem executable) via Bash — no Rails boot, so it's fast.
---

# Querying production logs with `swo`

`swo` is a CLI shipped as a rad_common gem executable. Invoke it with Bash. It reads an org-wide
SWO API token from `~/.config/swo/token`, so one token reads every app's logs.

## Commands

| Goal | Command |
|------|---------|
| Show matching lines (newest first) | `bundle exec swo search '<text>' [opts]` |
| Count matches over time (bar chart) | `bundle exec swo volume '<text>' [opts]` |
| Stream new matching lines live | `bundle exec swo tail '<text>' [opts]` |
| Verify the token works | `bundle exec swo auth` |

`tail` is long-running — only use it when the user explicitly wants to watch logs live, and run it
in the background. If `bundle exec swo` isn't found, the app likely needs `bundle install` (or
`rc_update`); mention that.

## Options

- `--host NAME` — target app. The SWO host **is the Heroku app name** (e.g. `cp-deals-admin`,
  `better-way-pep`), *not* the directory name. If omitted, `swo` auto-detects the project's single
  production Heroku app from its git remotes. If a project has zero or multiple matches, `swo`
  aborts and lists them — re-run with `--host NAME` for the one the user means (ask if it's
  unclear which). `--all` queries every app.
- `-p web|worker|router|web.1` — program
- `-s 30m|6h|7d` — time window (defaults: search `1h`, volume `7d`, tail `2m`)
- `-n N` — max lines for search (default 200)
- `-b day|hour` — bucket for volume (default day)
- `--json` — raw JSON, one object per line

## How to use it well

- **Pick the right command:** "what happened / show me" → `search`; "how many / how often / when"
  → `volume`.
- **`filter` matches log TEXT, not Ruby class names.** Search for strings that actually appear in
  the log line — a URL path, `class=AutoRefillJob`, `program:web`, an error message. Searching for
  a bare class name only works if that exact string is logged.
- **Don't hand-write `host:`/`hostname:` into the search text** — use `--host`. (`swo` builds the
  correct `host:` filter itself; `hostname:` silently returns zero rows.)
- **Quote multi-word phrases** so they match as a phrase: `swo search '"completed payment"'`.
- **Use `--json`** when you'll parse fields or summarize counts yourself rather than just showing
  the user lines.
- **Retention is ~9 days** — older `--since` windows return empty (the CLI warns).
- **`volume` counts client-side by paging** (SWO has no aggregation API). Over very wide windows it
  warns that the total is a lower bound — narrow `--since` or add filter text for an exact count.
- **First use on a machine:** run `bundle exec swo auth`. If it reports no token, tell the user to
  put their SWO API token in `~/.config/swo/token` (`chmod 600`).

## Examples

- "any errors in prod the last hour" → `bundle exec swo search 'error' -p web -s 1h`
- "how many AutoRefillJobs ran today" → `bundle exec swo volume 'AutoRefillJob' -s 24h -b hour`
- "check mayoshift for timeouts" → `bundle exec swo search 'timeout' --host mayoshift -s 6h`
- "show me 5xx responses this week" → `bundle exec swo volume '"status=5"' -s 7d -b day`
