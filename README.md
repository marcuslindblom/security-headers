# Analyse your HTTP response headers

Quickly and easily assess the security of your HTTP response headers
A simple example:

```yml
on:
  deployment_status

jobs:
  security-headers-check:
    name: Analyse HTTP response headers
    runs-on: ubuntu-latest    
    steps:
      - uses: actions/checkout@v2
        with:
          repository: marcuslindblom/security-headers
      - uses: marcuslindblom/security-headers@main
        with:
          url: ${{ secrets.SECURITY_HEADERS_URL }}
          grade: C
```
