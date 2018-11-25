message('Thank you for submitting a pull request to SwifterSwift. The team will review your submission as soon as possible.')

# Checks for modified source files
source_changes_exist = !git.modified_files.grep(/Sources/).empty?

# Checks for changelog entry
no_changelog_entry = !git.modified_files.include?("CHANGELOG.md")

# Checks for tests
no_test_changes = git.modified_files.grep(/Tests/).empty?

if source_changes_exist && no_test_changes 
    warn('Consider adding tests for new extensions or updating existing tests for a modified SwifterSwift extension')
end

if source_changes_exist && no_changelog_entry
    warn('The source files have been modified. Please consider adding a CHANGELOG entry if necessary.')
end

swiftlint.lint_files
        
# Checks if pull request is labeled as [WIP]
warn('This pull request is marked as Work in Progress. DO NOT MERGE!') if github.pr_title.include? "[WIP]"

# Xcode summary
def summary(platform:)
    xcode_summary.report "xcodebuild-#{platform}.json"
end
  
def label_tests_summary(label:, platform:) 
    file_name = "xcodebuild-#{platform}.json"
    json = File.read(file_name)
    data = JSON.parse(json)
    data["tests_summary_messages"].each { |message| 
        if !message.empty?
            message.insert(1, " " + label + ":")
        end
    }
    File.open(file_name,"w") do |f|
        f.puts JSON.pretty_generate(data)
    end 
end

label_tests_summary(label: "iOS", platform: "ios")
label_tests_summary(label: "tvOS", platform: "tvos")
label_tests_summary(label: "macOS", platform: "macos")
  
summary(platform: "ios")
summary(platform: "tvos")
summary(platform: "macos")
summary(platform: "watchos")
