# Axon Server singeleton StatefulSet Helm Chart

## Installatie van eerste node

```bash

# aanmaken namespace
kubectl create namespace axonserver

# installeren van de eerste singleton StatefulSet node
helm install axonserver-1 helm/axon-prod \
    --namespace axonserver --create-namespace \
    --set singleton.nodeName=axonserver-1 \
    --set singleton.firstNodeName=axonserver-1

# Wachten tot axonserver-1 volledig is opgestart
kubectl rollout status statefulset/axonserver-1 -n axonserver

# Port-forward naar de dashboard UI van axonserver-1
kubectl port-forward statefulset/axonserver-1 8024:8024 -n axonserver
```

Navigeer naar de dashboard UI van axonserver-1 via `http://localhost:8024` om de installatie van de eerste node te voltooien.

In de Complete installation dialog
- selecteer 'Start node and initialize multi-node cluster' in de *Initialize action* dropdown
- vul in 'default' in de *With initial context name* input
- vink de *DCB contexts* checkbox aan
- klik op de *Complete* button om de installatie af te ronden

Klik op de Utilities/License tab. Klik op de *Upload License* button om het licentiebestand te selecteren en te uploaden.

## Installatie van de tweede node

```bash
# installeren van de tweede singleton StatefulSet node
helm install axonserver-2 helm/axon-prod \
    --namespace axonserver \
    --set singleton.nodeName=axonserver-2 \
    --set singleton.firstNodeName=axonserver-1

# Wachten tot axonserver-2 volledig is opgestart
kubectl rollout status statefulset/axonserver-2 -n axonserver

# Port-forward naar de dashboard UI van axonserver-2
kubectl port-forward statefulset/axonserver-2 8025:8024 -n axonserver
```

Navigeer naar de dashboard UI van axonserver-2 via `http://localhost:8025` om de installatie van de tweede node te voltooien.

In de Complete installation dialog
- selecteer 'Join existing cluster' voor de *Initialize action*
- vul in 'axonserver-1' voor de *Host address*
- selecteer '8224' voor de *Host port*
- klik op de *Complete* button om de installatie af te ronden

De licentie van axonserver-1 wordt automatisch gedeeld met axonserver-2.

## Installatie van de derde en volgende nodes

Herhaal de stappen van de tweede node installatie, maar vervang `axonserver-2` door `axonserver-3` (en later `axonserver-4`, etc.) in de helm install en port-forward commando's.
