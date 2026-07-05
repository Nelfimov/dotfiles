local tsdk_path = "/.yarn/sdks/typescript/lib"
local project_root = vim.fs.root(vim.uv.cwd(), ".git")
local vtsls = {
  settings = {
    typescript = {
      preferences = {
        preferTypeOnlyAutoImports = true,
      },
    },
  },
}

if project_root and vim.uv.fs_stat(project_root .. tsdk_path) then
  vtsls.settings.typescript.tsdk = project_root .. tsdk_path
  vtsls.init_options = { hostInfo = "neovim" }
end

local function terraform_root(fname)
  return require("lspconfig.util").root_pattern(
    ".terraform",
    ".terraform.lock.hcl",
    "*.tf",
    "*.tfvars",
    "terragrunt.hcl"
  )(fname)
end

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      terraformls = {
        root_dir = terraform_root,
      },
      nil_ls = {
        settings = {
          ["nil"] = {
            nix = {
              flake = {
                autoArchive = true,
              },
            },
          },
        },
      },
      vtsls = vtsls,
      solargraph = {
        mason = false,
      },
      rubocop = {
        mason = false,
        cmd = { "bundle", "exec", "rubocop", "--lsp" },
      },
      ruby_lsp = {
        mason = false,
        cmd = { "bundle", "exec", "ruby-lsp" },
      },
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/deployment.json"] = "{specs,spec}/**/*.{deployment}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/ingress.json"] = "{specs,spec}/**/*.{ingress}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/service.json"] = "{specs,spec}/**/*.{service}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/job.json"] = "{specs,spec}/**/*.{job}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/cronjob.json"] = "{specs,spec}/**/*.{cronjob}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/persistentvolume.json"] = "{specs,spec}/**/*.{pv}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/persistentvolumeclaim.json"] = "{specs,spec}/**/*.{pvc}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/daemonset.json"] = "{specs,spec}/**/*.{daemonset}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/namespace.json"] = "{specs,spec}/**/*.{namespace}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/rolebinding.json"] = "{specs,spec}/**/*.{role*binding}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/clusterrolebinding.json"] = "{specs,spec}/**/*.{clusterrole*binding}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/role.json"] = "{specs,spec}/**/*.{role}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/clusterrole.json"] = "{specs,spec}/**/*.{cluster.role}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/configmap.json"] = "{specs,spec}/**/*.{configmap}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/secret.json"] = "{specs,spec}/**/*.{secret}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/statefulset.json"] = "{specs,spec}/**/*.{statefulset}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/storageclass.json"] = "{specs,spec}/**/*.{storageclass,sc}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/horizontalpodautoscaler.json"] = "{specs,spec}/**/*.{hpa,horizontalpodautoscaler}.{yml,yaml}",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/verticalpodautoscaler.json"] = "{specs,spec}/**/*.{vpa,verticalpodautoscaler}.{yml,yaml}",
              ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/all.json"] = "{specs,spec}/**/*.{kustomization,image-*}.{yml,yaml}",
              ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/kustomization-kustomize-v1.json"] = "{specs,spec}/**/*.{kustomization,image-*}.{yml,yaml}",
              ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/imagerepository-image-v1beta2.json"] = "{specs,spec}/**/*.{image-repo*}.{yml,yaml}",
              ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/imagepolicy-image-v1beta2.json"] = "{specs,spec}/**/*.{image-policy*}.{yml,yaml}",
              ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/imageupdateautomation-image-v1beta2.json"] = "{specs,spec}/**/*{image*auto*}.{yml,yaml}",
              ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/helmrelease-helm-v2.json"] = "{specs,spec}/**/*.{helm*release*}.{yml,yaml}",
              ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/helmrepository-source-v1.json"] = "{specs,spec}/**/*.{helm*repo*}.{yml,yaml}",
              ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/gitrepository-source-v1.json"] = "{specs,spec}/**/*.{git*repo*}.{yml,yaml}",
              ["https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/github-workflow.json"] = "**/workflows/*{yaml,yml}",
              ["https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/github-action.json"] = ".github/actions/*.{yaml,yml}",
              ["https://json.schemastore.org/github-issue-forms.json"] = ".github/ISSUE_TEMPLATE/.{yaml,yml}",
              ["https://json.schemastore.org/github-issue-config.json"] = ".github/ISSUE_TEMPLATE/config.{yaml,yml}",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.{yaml,yml}",
              ["https://raw.githubusercontent.com/devcontainers/spec/master/schemas/devContainer.base.schema.json"] = "devcontainer.json",
              ["https://raw.githubusercontent.com/nrwl/nx/refs/heads/master/packages/nx/schemas/project-schema.json"] = "project.json",
              ["https://raw.githubusercontent.com/nrwl/nx/refs/heads/master/packages/nx/schemas/nx-schema.json"] = "nx.json",
            },
          },
        },
      },
    },
  },
}
