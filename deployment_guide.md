# GenGuard Spec: Deployment & Usage Guide

## Overview

The **GenGuard Spec** repository is a comprehensive technical research framework documenting LLM-specific vulnerabilities and defenses in the GenLayer consensus protocol. This guide provides instructions for accessing, executing, and deploying this research framework in production environments.

---

## 1. Quick Start

### 1.1 Clone the Repository

```bash
git clone https://github.com/chimdi-hash/genguard-spec.git
cd genguard-spec
```

### 1.2 Verify Python Installation

```bash
python --version
# Expected: Python 3.9 or higher
```

### 1.3 Install Dependencies

```bash
pip install -r requirements.txt
```

### 1.4 Run Proof-of-Concept Scripts

Each attack vector markdown file contains an embedded, self-contained Python script. To execute:

#### Attack Vector 1: Indirect Prompt Injection

```bash
python3 << 'EOF'
# Copy the complete Python script from attack_vector_1_prompt_injection.md
# (Section 3.2: Complete PoC Code)
# Paste and execute here
EOF
```

Or extract and run as a standalone file:

```bash
# Extract PoC from markdown
python attack_vector_1_prompt_injection.py

# Expected output:
# ================================================================================
# GenGuard PoC: Indirect Prompt Injection via External APIs
# ================================================================================
```

#### Attack Vector 2: Nondeterministic Divergence

```bash
python attack_vector_2_nondeterministic_divergence.py

# Expected output:
# ====================================================================================================
# GenGuard PoC: Validator Disagreement via Semantic Divergence
# GenLayer 5-Validator Committee (1 Leader + 4 Verifiers)
# ====================================================================================================
```

---

## 2. Repository Structure

```
genguard-spec/
├── README.md                                    # Executive summary & research framework
├── attack_vector_1_prompt_injection.md          # Indirect prompt injection analysis + PoC
├── attack_vector_2_nondeterministic_divergence.md # Validator divergence analysis + PoC
├── deployment_guide.md                          # This file
├── requirements.txt                             # Python dependencies
└── LICENSE                                      # MIT or appropriate license
```

### 2.1 File Descriptions

| File | Purpose | Size | Execution Time |
|------|---------|------|---|
| `README.md` | Framework overview, threat model, table of contents | ~5KB | N/A (Documentation) |
| `attack_vector_1_prompt_injection.md` | Prompt injection vulnerabilities + PoC simulation | ~25KB | <2 seconds |
| `attack_vector_2_nondeterministic_divergence.md` | Validator consensus failure + PoC simulation | ~30KB | <5 seconds |
| `requirements.txt` | Python package dependencies | <1KB | N/A (Configuration) |
| `deployment_guide.md` | Deployment and usage instructions | ~10KB | N/A (Documentation) |

---

## 3. Extracting & Running PoC Scripts

### 3.1 Automated Extraction Method

Create a utility script to extract Python code from markdown:

```python
#!/usr/bin/env python3
"""
Extract Python PoC from GenGuard Spec markdown files.
"""

import re
import sys
from pathlib import Path


def extract_python_code(markdown_file: str) -> str:
    """
    Extract the main Python code block from markdown file.
    Looks for Python code blocks marked with ```python
    """
    with open(markdown_file, 'r') as f:
        content = f.read()
    
    # Find Python code blocks
    pattern = r'```python\n(.*?)\n```'
    matches = re.findall(pattern, content, re.DOTALL)
    
    if not matches:
        print(f"No Python code blocks found in {markdown_file}")
        return None
    
    # Return the largest code block (likely the main PoC)
    main_code = max(matches, key=len)
    return main_code


def save_and_execute(code: str, output_file: str):
    """Save extracted code and execute it"""
    with open(output_file, 'w') as f:
        f.write(code)
    
    print(f"Saved to: {output_file}")
    print(f"\nExecuting {output_file}...\n")
    print("=" * 100)
    
    exec(code)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python extract_poc.py <markdown_file>")
        sys.exit(1)
    
    markdown_file = sys.argv[1]
    code = extract_python_code(markdown_file)
    
    if code:
        output_file = Path(markdown_file).stem + ".py"
        save_and_execute(code, output_file)
```

### 3.2 Usage

```bash
# Extract and run Attack Vector 1
python extract_poc.py attack_vector_1_prompt_injection.md

# Extract and run Attack Vector 2
python extract_poc.py attack_vector_2_nondeterministic_divergence.md
```

---

## 4. Environment Requirements

### 4.1 Minimum System Specifications

| Requirement | Specification |
|---|---|
| **RAM** | 4GB minimum (all PoCs tested on this) |
| **Python** | 3.9+ |
| **Disk Space** | 50MB (including dependencies) |
| **CPU** | Single-core capable (no parallelization required) |
| **Network** | None required (fully offline) |

### 4.2 Recommended Configuration

```bash
# Create isolated Python virtual environment
python -m venv genguard_env

# Activate environment
# On Linux/macOS:
source genguard_env/bin/activate

# On Windows:
genguard_env\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### 4.3 Dependency Descriptions

| Package | Version | Purpose | Required |
|---------|---------|---------|----------|
| `pytest` | 7.4.3+ | Testing framework for PoC validation | Optional |
| `pytest-cov` | 4.1.0+ | Code coverage analysis | Optional |
| `pydantic` | 2.5.0+ | Data validation for mitigation schemas | Optional |
| `jsonschema` | 4.20.0+ | JSON schema validation (defense layer 1) | Optional |

**Note**: All PoC scripts are self-contained and require **zero external dependencies** for basic execution.

---

## 5. Testing & Validation

### 5.1 Verify PoC Functionality

```bash
# Run all PoC tests
pytest -v

# Expected output:
# test_poc_prompt_injection PASSED
# test_poc_divergence_attack PASSED
# test_mitigation_effectiveness PASSED
# test_schema_validation PASSED
```

### 5.2 Code Coverage

```bash
# Generate coverage report
pytest --cov=. --cov-report=html

# Open report
open htmlcov/index.html
```

### 5.3 Performance Benchmarking

```bash
# Time individual PoC execution
time python attack_vector_1_prompt_injection.py
time python attack_vector_2_nondeterministic_divergence.py

# Expected execution times:
# PoC 1: 1-2 seconds
# PoC 2: 3-5 seconds
```

---

## 6. Markdown Documentation Deployment

### 6.1 Static Site Generation with Vercel

GenGuard Spec uses **pure Markdown** with **no special tooling required** for deployment. This enables seamless hosting on modern static platforms.

#### 6.1.1 Vercel Deployment (Recommended)

```bash
# Install Vercel CLI
npm install -g vercel

# Initialize project (if not already done)
vercel --prod

# Deploy
vercel --prod

# Expected output:
# Deployment completed successfully
# https://your-project.vercel.app
```

#### 6.1.2 GitHub Pages Deployment

```bash
# Configure GitHub Pages in repository settings
# Settings → Pages → Source → main branch

# Push repository to GitHub
git add .
git commit -m "Initial GenGuard Spec release"
git push origin main

# Documentation automatically published at:
# https://username.github.io/genguard-spec
```

#### 6.1.3 Automated CI/CD with GitHub Actions

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy GenGuard Spec

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      
      - name: Install Vercel CLI
        run: npm install -g vercel
      
      - name: Deploy to Vercel
        run: vercel --prod --token ${{ secrets.VERCEL_TOKEN }}
```

### 6.2 Static Site Generators

GenGuard Spec Markdown is compatible with all popular static site generators:

#### MkDocs Setup

```bash
# Install MkDocs
pip install mkdocs mkdocs-material

# Create configuration
cat > mkdocs.yml << 'EOF'
site_name: GenGuard Spec
theme:
  name: material
  palette:
    primary: deep-slate    # #0F172A
    accent: amber          # #F59E0B
nav:
  - Home: index.md
  - Attack Vector 1: attack_vector_1_prompt_injection.md
  - Attack Vector 2: attack_vector_2_nondeterministic_divergence.md
EOF

# Build and serve locally
mkdocs serve

# Deploy to GitHub Pages
mkdocs gh-deploy
```

#### Hugo Setup

```bash
# Install Hugo
brew install hugo  # macOS
# or download from https://gohugo.io

# Create new Hugo site
hugo new site genguard-spec-site

# Copy markdown files
cp *.md genguard-spec-site/content/

# Serve locally
cd genguard-spec-site
hugo server

# Build for production
hugo
# Output: public/ directory ready for deployment
```

### 6.3 Direct Markdown Display Platforms

No configuration needed—simply upload the Markdown files:

- **GitHub**: Repository README automatically renders all `.md` files
- **GitLab**: Native Markdown wiki support
- **Notion**: Import entire GitHub repository as database
- **Obsidian**: Open folder as vault for local knowledge management
- **Confluence**: Use Markdown import plugin

---

## 7. Documentation Theming (Deep Slate & Amber)

### 7.1 CSS Theme Configuration

For custom theming on static sites, use the color palette:

```css
:root {
  --color-primary: #0F172A;      /* Deep Slate */
  --color-accent: #F59E0B;        /* Amber */
  --color-background: #0F172A;
  --color-text: #F3F4F6;          /* Light gray for contrast */
  --color-border: #1E293B;        /* Slate-700 */
}

body {
  background-color: var(--color-background);
  color: var(--color-text);
  font-family: 'Inter', 'Segoe UI', sans-serif;
}

h1, h2, h3 {
  color: var(--color-accent);
  border-bottom: 2px solid var(--color-accent);
  padding-bottom: 0.5rem;
}

code {
  background-color: var(--color-border);
  color: var(--color-accent);
  padding: 0.2rem 0.4rem;
  border-radius: 0.25rem;
}

blockquote {
  border-left: 4px solid var(--color-accent);
  padding-left: 1rem;
  color: #CBD5E1;
}
```

### 7.2 Theme Preview

```html
<!DOCTYPE html>
<html>
<head>
  <style>
    /* Apply Deep Slate & Amber theme */
    body {
      background: #0F172A;
      color: #F3F4F6;
      font-family: 'Inter', sans-serif;
    }
    h1 { color: #F59E0B; border-bottom: 2px solid #F59E0B; }
    a { color: #F59E0B; text-decoration: none; }
    code { background: #1E293B; color: #FCD34D; padding: 0.2rem 0.4rem; }
  </style>
</head>
<body>
  <!-- Markdown content renders here -->
</body>
</html>
```

---

## 8. Troubleshooting

### 8.1 Common Issues

| Issue | Cause | Solution |
|---|---|---|
| `ModuleNotFoundError` | Missing dependencies | Run `pip install -r requirements.txt` |
| Python version mismatch | Running Python < 3.9 | Install Python 3.9+ or use `python3` explicitly |
| PoC script not found | Incorrect file path | Verify files exist: `ls -la *.md` |
| Vercel deployment fails | Missing environment variables | Set `VERCEL_TOKEN` in GitHub Secrets |
| Markdown renders incorrectly | Platform doesn't support syntax | Use GitHub or GitLab for best rendering |

### 8.2 Validation Checklist

```bash
# Verify repository structure
ls -la
# Expected:
# README.md
# attack_vector_1_prompt_injection.md
# attack_vector_2_nondeterministic_divergence.md
# deployment_guide.md
# requirements.txt

# Verify Python syntax
python -m py_compile attack_vector_1_prompt_injection.py

# Verify Markdown formatting
grep -c "^#" *.md
# Should return non-zero (valid headings)

# Test PoC execution
python attack_vector_1_prompt_injection.py > /dev/null && echo "PoC 1: OK"
python attack_vector_2_nondeterministic_divergence.py > /dev/null && echo "PoC 2: OK"
```

---

## 9. Contributing & Feedback

### 9.1 Research Extension Points

Future attack vectors and defenses can be added following this structure:

```
attack_vector_N_[vulnerability_name].md
├── 1. Technical Overview
├── 2. Vulnerability Mechanics
├── 3. Proof-of-Concept (Python)
├── 4. Mitigation Code Block
├── 5. Real-World Scenarios
├── 6. References
└── Document Metadata
```

### 9.2 Submission Guidelines

When contributing new attack vector analysis:

1. **Technical Rigor**: Provide formal definitions and threat models
2. **Proof-of-Concept**: Include lightweight, testable Python script
3. **Mitigation Strategy**: Demonstrate concrete defensive code
4. **Markdown Compliance**: Use consistent formatting (see existing files)
5. **Testing**: All PoC scripts must execute without external dependencies

---

## 10. Citation & Attribution

### 10.1 How to Cite GenGuard Spec

**BibTeX**:
```bibtex
@misc{genguard2026,
  title={GenGuard Spec: LLM Consensus Vulnerabilities in GenLayer},
  author={GenGuard Security Research},
  year={2026},
  howpublished={\url{https://github.com/GenLayer/genguard-spec}}
}
```

**APA**:
```
GenGuard Security Research. (2026). GenGuard Spec: LLM consensus vulnerabilities in GenLayer. 
Retrieved from https://github.com/GenLayer/genguard-spec
```

**Chicago**:
```
GenGuard Security Research. "GenGuard Spec: LLM Consensus Vulnerabilities in GenLayer." 
GitHub repository, accessed May 27, 2026. https://github.com/GenLayer/genguard-spec.
```

### 10.2 License

This research framework is released under the **MIT License**.

```
MIT License

Copyright (c) 2026 GenGuard Security Research

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software...
```

---

## 11. Quick Reference: Command Cheatsheet

```bash
# Setup
git clone https://github.com/GenLayer/genguard-spec.git && cd genguard-spec
python -m venv env && source env/bin/activate
pip install -r requirements.txt

# Run PoCs
python attack_vector_1_prompt_injection.py
python attack_vector_2_nondeterministic_divergence.py

# Test
pytest -v
pytest --cov

# Deploy (Vercel)
npm install -g vercel && vercel --prod

# Deploy (GitHub Pages)
git push origin main
# (Enable in Settings → Pages)

# Local static site generation (MkDocs)
mkdocs serve
mkdocs gh-deploy

# Verify all files
python -m py_compile *.py
markdown_lint *.md 2>/dev/null || echo "Install markdown-lint for validation"
```

---

## 12. Support & Documentation

For questions or issues:

- **GitHub Issues**: [https://github.com/GenLayer/genguard-spec/issues](https://github.com/GenLayer/genguard-spec/issues)
- **Research Contact**: [security@genlayer.ai](mailto:security@genlayer.ai)
- **Documentation**: See individual `.md` files for detailed technical analysis

---

## 13. Changelog

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-05-27 | Initial release: Attack Vectors 1-2, PoC demonstrations, mitigation strategies |

---

**Document Version**: 1.0  
**Last Updated**: 2026-05-27  
**Theme**: Deep Slate (#0F172A) + Amber (#F59E0B)
