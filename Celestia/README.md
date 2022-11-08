Official documentation:
> [Validator setup instructions](https://docs.celestia.org/nodes/validator-node)

F5nodes doc:
> [Validator setup instructions](https://notion.f5nodes.com/Validator-Node-Full-Node-a68e9aaec70c4ce2883768a1591068b6)

Chain explorer:
> [Explorer for chain](https://testnet.mintscan.io/celestia-testnet/validators)

## I am lazy and sick. Therefore, there are no scripts yet

## Add my peers to server
```
BOOTSTRAP_PEERS=$(curl -sL https://raw.githubusercontent.com/Archideus/nodes_scripts/main/Celestia/my-peers-list.txt | tr -d '\n')
echo $BOOTSTRAP_PEERS
sed -i.bak -e "s/^bootstrap-peers *=.*/bootstrap-peers = \"$BOOTSTRAP_PEERS\"/" $HOME/.celestia-app/config/config.toml

```

## Recomended Subspace Hardware


