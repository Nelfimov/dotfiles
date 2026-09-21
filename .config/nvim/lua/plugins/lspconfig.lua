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
            schemas = {
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/deployment.json"] = "*.deployment.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/ingress.json"] = "*.ingress.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/service.json"] = "*.service.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/job.json"] = "*.job.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/cronjob.json"] = "*.cronjob.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/persistentvolume.json"] = "*.pv.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/persistentvolumeclaim.json"] = "*.pvc.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/namespace.json"] = "*.namespace.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/rolebinding.json"] = "*.role*binding.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/clusterrolebinding.json"] = "*.clusterrole*binding.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/role.json"] = "*.role.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/clusterrole.json"] = "*.clusterrole.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/configmap.json"] = "*.{configmap,cm}.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/secret.json"] = "*.{secret,secrets}.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/statefulset.json"] = "*.{statefulset,ss}.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/storageclass.json"] = "*.{storageclass,sc}.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/horizontalpodautoscaler.json"] = "*.{hpa,horizontalpodautoscaler}.y*ml",
              ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/verticalpodautoscaler.json"] = "*.{vpa,verticalpodautoscaler}.y*ml",
              ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/all.json"] = "*{kustomization,image-*}.y*ml",
              ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/kustomization-kustomize-v1.json"] = "*{kustomization,image-*}.y*ml",
              ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/imagerepository-image-v1.json"] = "*.image-repo*.y*ml",
              ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/imagepolicy-image-v1beta2.json"] = "*.image-policy*.y*ml",
              ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/imageupdateautomation-image-v1beta2.json"] = "*.image*auto*.y*ml",
              ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/helmrelease-helm-v2.json"] = "*.{helm*release,hr}.y*ml",
              ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/helmrepository-source-v1.json"] = "*.helm*repo*.y*ml",
              ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/gitrepository-source-v1.json"] = "*git*repo*.y*ml",
              ["https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/github-workflow.json"] = ".github/workflows/*.y*ml",
              ["https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/github-action.json"] = ".github/actions/*.y*ml",
              ["https://json.schemastore.org/github-issue-forms.json"] = ".github/ISSUE_TEMPLATE/*.y*ml",
              ["https://json.schemastore.org/github-issue-config.json"] = ".github/ISSUE_TEMPLATE/config.y*ml",
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
