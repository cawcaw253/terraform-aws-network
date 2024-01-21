# How to generate documents

```
  docker run --rm --volume "$(pwd):/terraform-docs" -u $(id -u) quay.io/terraform-docs/terraform-docs:0.16.0 markdown -c /terraform-docs/.terraform-docs.yaml /terraform-docs --output-file /terraform-docs/README.md
```
