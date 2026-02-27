# Skill: Generate Naftiko Sandbox README

Generate a consistent `README.md` for any Naftiko Sandbox repository by following the established structure and boilerplate used across all sandboxes.

## Usage

Run this skill from inside a Naftiko Sandbox directory, or pass the sandbox directory path as an argument:

```
/naftiko-sandbox-readme
/naftiko-sandbox-readme notion-sandbox
```

## What This Skill Does

### Step 1: Gather Information

Before writing, inspect the sandbox repository and collect:

- **Sandbox name** — from the directory name, the `apis.yml` `name:` field, or the argument passed
- **API name(s)** — from `apis.yml` entries under `apis:`
- **Description** — from the `apis.yml` `description:` field or any existing README
- **OpenAPI files** — files in the `openapi/` directory (`.yaml` or `.json`)
- **Skill files** — directories in the `skills/` directory, each containing a `SKILL.md`
- **Bruno collection** — folder name inside the `bruno/` directory

Read the `apis.yml` file to get accurate names, descriptions, and tags.

### Step 2: Generate the README

Produce a README following this exact structure. Replace placeholders with values gathered above.

---

```markdown
# {Sandbox Display Name}
{One or two sentence description of what this sandbox does. Mention that it uses an OpenAPI specification with examples, Microcks, and Bruno as the sandbox interface, and the GitHub repository as the vehicle for delivering a localized sandbox or enabling work directly with production APIs. Make it specific to the API being sandboxed.}

## APIs.json Index
There is an APIs.yml file in the root of this repository, providing an index of all the artifacts used as part of this capability, providing a machine-readable way to read, manage, and execute the resources available here.

## OpenAPI
This capability uses OpenAPI as the definition, providing a complete definition of all available paths for the {Sandbox Display Name}. The OpenAPI for this capability uses examples and Microcks extensions to mock the requests and responses for each API operation, something we will iterate and expand upon with richer examples as the capability evolves.

## Microcks
This capability uses Microcks to deliver the mock API. [You just install Microcks, with the Docker extension being the easiest](https://microcks.io/documentation/guides/installation/docker-desktop-extension/), [import the OpenAPI as a service]({path to main OpenAPI file}), and you have a mocked API for all APIs, available via REST and MCP APIs--providing a multi-protocol sandbox.

## Bruno
This capability [uses Bruno as the client](https://www.usebruno.com/), leveraging Bruno Collections pre-generated from the OpenAPI and Bruno environments that uses the localhost and port of Microcks to work with the mocked API. You just have to install Microcks, then open the collection provided in this repository, select the available environments, and begin calling the {Sandbox Display Name} via the sandbox or production.

## OpenAPIs
These are the OpenAPIs available for the {Sandbox Display Name}, which are made available via this sandbox API, which can be imported into Microcks and deployed as a sandbox using their mock feature.

  - [{OpenAPI Display Name}](openapi/{filename}.yaml)

## Skills
These skill guides document what you can do with each area of the {API Name}, including operations, parameters, example requests and responses, required OAuth scopes, and use cases.

  - [{Skill Name}](skills/{skill-folder}/SKILL.md) - {one-line description from the SKILL.md opening line}

## Support
Please provide any questions or feedback via GitHub issues, or just email kinlane@naftiko.io with feedback. The goal is to keep iterating upon this sandboxes using existing OpenAPI, Microcks, and Bruno features, offering value out of the box via this forkable capability.
```

---

## Rules

- Do NOT add any sections beyond those in the template above
- Do NOT add badges, shields, or icons
- Keep the Support section exactly as written — same email, same wording
- The APIs.json Index, OpenAPI, Microcks, and Bruno sections use standard boilerplate — only fill in the sandbox name and OpenAPI file path where indicated
- List OpenAPIs and Skills as indented bullet points with markdown links
- Pull the one-line skill description from the first sentence or subtitle of each `SKILL.md`
- After generating, ask the user if they want you to write it directly to `README.md` in the sandbox directory

## Example

See [microsoft-365-copilot-sandbox/README.md](https://github.com/naftiko/microsoft-365-copilot-sandbox/blob/main/README.md) as the canonical reference for this structure.
