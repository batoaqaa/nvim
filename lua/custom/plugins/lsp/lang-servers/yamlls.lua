local opts = require 'custom.plugins.lsp.opts'
return {
  capabilities = opts.capabilities,
  -- on_attach = opts.on_attach,
  settings = {
    yaml = {
      keyOrdering = false,
      schemaStore = {
        enable = true,
        url = 'https://www.schemastore.org/api/json/catalog.json',
      },
      schemas = {
        kubernetes = '*.yaml',
        ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*',
        ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
        ['https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json'] =
        'azure-pipelines.yml',
        ['http://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/*.{yml,yaml}',
        ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
        ['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
        ['http://json.schemastore.org/ansible-playbook'] = '*play*.{yml,yaml}',
        ['http://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
        ['https://json.schemastore.org/dependabot-v2'] = '.github/dependabot.{yml,yaml}',
        ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] =
        '*gitlab-ci*.{yml,yaml}',
        ['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json'] =
        '*api*.{yml,yaml}',
        ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] =
        '*docker-compose*.{yml,yaml}',
        ['https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json'] =
        '*flow*.{yml,yaml}',
      },
      format = {
        enable = true,
        printWidth = 120,
        proseWrap = 'always',
      },
      validate = false,
      completion = true,
      hover = true,
    },
  },

  -- settings = {
  --   yaml = {
  --     schemas = {
  --       ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
  --       ["../path/relative/to/file.yml"] = "/.github/workflows/*",
  --       ["/path/from/root/of/project"] = "/.github/workflows/*",
  --     },
  --   },
  -- }
}
