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
        cmd = { "ruby-lsp" },
      },
      yamlls = {
        settings = {
          yaml = {
            schemas = require("schemastore").yaml.schemas({
              extra = {
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.deployment.y*ml",
                  name = "foo.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/deployment.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.ingress.y*ml",
                  name = "foo.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/ingress.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.{service,svc}.y*ml",
                  name = "foo.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/service.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.job.y*ml",
                  name = "foo.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/job.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.cronjob.y*ml",
                  name = "foo.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/cronjob.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.pv.y*ml",
                  name = "foo.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/persistentvolume.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.pvc.y*ml",
                  name = "foo.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/persistentvolumeclaim.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.daemonset.y*ml",
                  name = "foo.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/daemonset.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.{ns,namespace}.y*ml",
                  name = "foo.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/namespace.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.role*binding.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/rolebinding.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.clusterrole*binding.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/clusterrolebinding.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.role.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/role.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.cluster.role.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/clusterrole.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "**.{configmap,cm}.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/configmap.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.secret.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/secret.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.{statefulset,ss}.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/statefulset.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.{storageclass,sc}.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/storageclass.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.{hpa,horizontalpodautoscaler}.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/horizontalpodautoscaler.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.{vpa,verticalpodautoscaler}.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/verticalpodautoscaler.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*{kustomization,image*}.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/all.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*kustomization.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/kustomization-kustomize-v1.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.image*repo*.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/imagerepository-image-v1beta2.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.image*policy*.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/imagepolicy-image-v1beta2.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.image*auto*.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/imageupdateautomation-image-v1beta2.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.{helm*release,hr}.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/helmrelease-helm-v2.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.helm*repo*.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/helmrepository-source-v1.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "*.git*repo*.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/gitrepository-source-v1.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "**/.github/workflows/*y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/github-workflow.json",
                },
                ["https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/github-workflow.json"] = "**/workflows/*{yaml,yml}",
                {
                  description = "My custom JSON schema",
                  fileMatch = "**/.github/actions/**/*/action.y*ml",
                  name = "config.json",
                  url = "https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/github-action.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = ".github/ISSUE_TEMPLATE/*.y*aml",
                  name = "config.json",
                  url = "https://json.schemastore.org/github-issue-forms.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = ".github/ISSUE_TEMPLATE/config.y*ml",
                  name = "config.json",
                  url = "https://json.schemastore.org/github-issue-config.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "project.json",
                  name = "project.json",
                  url = "https://raw.githubusercontent.com/nrwl/nx/refs/heads/master/packages/nx/schemas/project-schema.json",
                },
                {
                  description = "My custom JSON schema",
                  fileMatch = "nx.json",
                  name = "nx.json",
                  url = "https://raw.githubusercontent.com/nrwl/nx/refs/heads/master/packages/nx/schemas/nx-schema.json",
                },
              },
            }),
          },
        },
      },
    },
  },
}
