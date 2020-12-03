# frozen_string_literal: true

require "dependabot/pull_request_creator"

module Dependabot
  class MultipleDepsPullRequestCreator < PullRequestCreator
    require "pull_request_creator/message_builder"
    require "pull_request_creator/branch_namer"

    def message_builder
      MultipleDepsMessageBuilder.new(
          source: source,
          dependencies: dependencies,
          files: files,
          credentials: credentials,
          commit_message_options: commit_message_options,
          pr_message_header: pr_message_header,
          pr_message_footer: pr_message_footer,
          vulnerabilities_fixed: vulnerabilities_fixed,
          github_redirection_service: github_redirection_service
      )
    end

    def branch_namer
      @branch_namer ||=
          MultipleDepsBranchNamer.new(
              dependencies: dependencies,
              files: files,
              target_branch: source.branch,
              separator: branch_name_separator,
              prefix: branch_name_prefix
          )
    end
  end
end