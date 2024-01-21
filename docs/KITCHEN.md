## Commands and Example Usage

### Commands

| Commands                                        | Description                                                                                                                |
| ------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| kitchen console                                 | # Test Kitchen Console!                                                                                                    |
| kitchen converge [INSTANCE\|REGEXP\|all]        | # Change instance state to converge. Use a provisioner to configure one or more instances                                  |
| kitchen create [INSTANCE\|REGEXP\|all]          | # Change instance state to create. Start one or more instances                                                             |
| kitchen destroy [INSTANCE\|REGEXP\|all]         | # Change instance state to destroy. Delete all information for one or more instances                                       |
| kitchen diagnose [INSTANCE\|REGEXP\|all]        | # Show computed diagnostic configuration                                                                                   |
| kitchen doctor INSTANCE\|REGEXP                 | # Check for common system problems                                                                                         |
| kitchen exec INSTANCE\|REGEXP -c REMOTE_COMMAND | # Execute command on one or more instance                                                                                  |
| kitchen help [COMMAND]                          | # Describe available commands or one specific command                                                                      |
| kitchen init                                    | # Adds some configuration to your cookbook so Kitchen can rock                                                             |
| kitchen list [INSTANCE\|REGEXP\|all]            | # Lists one or more instances                                                                                              |
| kitchen login INSTANCE\|REGEXP                  | # Log in to one instance                                                                                                   |
| kitchen package INSTANCE\|REGEXP                | # package an instance                                                                                                      |
| kitchen setup [INSTANCE\|REGEXP\|all]           | # Change instance state to setup. Prepare to run automated tests. Install busser and related gems on one or more instances |
| kitchen test [INSTANCE\|REGEXP\|all]            | # Test (destroy, create, converge, setup, verify and destroy) one or more instances                                        |
| kitchen verify [INSTANCE\|REGEXP\|all]          | # Change instance state to verify. Run automated tests on one or more instances                                            |
| kitchen version                                 | # Print Test Kitchen's version information                                                                                 |

### Example Usage

```
  # Provision
  > kitchen converge

  # Verify
  > kitchen verify

  # Destroy
  > kitchen destroy

  # Test and destroy all
  > kitchen test -d always
  > kitchen test -d always -l warn
```
