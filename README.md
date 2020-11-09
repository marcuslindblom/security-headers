# Analyse your HTTP response headers

Quickly and easily assess the security of your HTTP response headers using using securityheaders.com

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
          grade: A
```

Example output:

![Output](https://p1.f0.n0.cdn.getcloudapp.com/items/8LurzpvN/Screenshot%202020-11-09%20at%2010.13.37.png)
