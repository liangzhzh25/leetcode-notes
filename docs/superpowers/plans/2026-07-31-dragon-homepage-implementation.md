# Dragon Homepage Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Build and deploy the approved dragon-themed Quartz homepage.

**Architecture:** Keep the homepage markup in the canonical default index, scope all visual changes to the index slug, and serve an optimized local hero asset from Quartz static resources. The existing sync workflow remains unchanged.

**Tech Stack:** Quartz 5, Markdown with embedded HTML, SCSS, GitHub Actions, GitHub Pages

## Global Constraints

- Do not change article-page layout or content.
- Keep all links relative so the GitHub Pages subpath works.
- Preserve both desktop and mobile readability.
- Keep the original user image outside Git; commit only the optimized web asset.

### Task 1: Add the homepage asset and markup

- [ ] Verify the current build does not contain `.lc-home`.
- [ ] Convert the supplied PNG to `quartz/static/dragon-hero.webp`.
- [ ] Replace `default-index.md` and `content/index.md` with identical approved markup.
- [ ] Include four relative links to the generated note slugs.

### Task 2: Add homepage-only responsive styles

- [ ] Add styles under `body[data-slug="index"]`.
- [ ] Hide the duplicate article title/meta only on the index page.
- [ ] Expand the index center column while retaining Quartz navigation controls.
- [ ] Add mobile hero cropping and single-column entry cards.

### Task 3: Build and verify

- [ ] Run the Quartz build.
- [ ] Confirm hero markup and all four links exist in `public/index.html`.
- [ ] Confirm `public/1.-两数之和.html` has no `.lc-home`.
- [ ] Confirm `public/static/dragon-hero.webp` exists.

### Task 4: Publish and verify online

- [ ] Commit only the intended homepage files and design documents.
- [ ] Push `v5`.
- [ ] Wait for the GitHub Pages workflow to succeed.
- [ ] Fetch the online homepage and verify HTTP 200 plus the new hero copy.
