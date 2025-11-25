Policy-as-code for this repo

Overview
- This folder contains Rego policies (Open Policy Agent) tailored to Terraform plan JSON produced by `terraform show -json`.

Files
- `policy/terraform/*.rego`: rules that produce `deny` messages when a check fails.

How to run (local)

1. Install `conftest` (used to run Rego policies):

   - macOS (Homebrew):
     ```
     brew install conftest
     ```

2. Create a Terraform plan JSON from your Terraform workspace (run from the `terraform/` directory or adjust paths):

   ```
   cd terraform
   terraform init -backend=false
   terraform plan -out=plan.tfplan
   terraform show -json plan.tfplan > plan.json
   cd ..
   ```

3. Run conftest against the plan JSON with these policies:

   ```
   conftest test terraform/plan.json --policy policy/terraform
   ```

Notes
- The Rego checks are intentionally conservative and readable. You can refine them to match your module attributes and naming conventions.
- If your module stores IAM policies in separate resources or embeds them differently, adapt `iam_no_wildcards.rego` to parse JSON policy strings.

CI integration
- Add a workflow or step to generate `plan.json` in a PR environment and run `conftest`.
