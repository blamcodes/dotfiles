# Generating SSH Key

[Github Doc](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

```shell
ssh-keygen -t ed255109 -C "email"
```

## Start ssh-agent in the background
```console
eval "$(ssh-agent -s)"
```

```shell
ssh-add ~/.ssh/id_ed25519
```


