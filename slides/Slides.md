---
marp: true
theme: custom-default
footer: 'https://chris-ayers.com'
---

![bg right](img/background.jpg)

![bicep w:150px](img/bicep-logo.png)
# Deploying Azure Resources with Bicep Scopes
![azure w:150px](img/azure-logo.png)

---

![bg right fit](img/bicep-arm.png)
## Bicep
Bicep is a domain-specific language (DSL) that uses declarative syntax to deploy Azure resources. Bicep provides concise syntax, reliable type safety, and support for code reuse. 


---

![bg left fit 90%](img/2-hierarchy.png)
## Scopes

* Resource Groups
* Subscriptions
* Management Groups
* Tenant

---

## Cli Commands to deploy

- az deployment group create --template-file main.bicep
- az deployment sub create --template-file main.bicep
- az deployment mg create --template-file main.bicep
- az deployment tenant create --template-file main.bicep

---

![bg fit](img/CARML.png)

---

![bg fit right 90%](img/layers.png)
## CARML
Modules for almost every Azure Service that is ready to use.
Allows for quick deployment of resources with minimal code.

---

## Identities

<div class="columns">
<div>
Multiple Identities can be used to deploy resources to different scopes or security boundaries.<br>
Dev SP can deploy to a single dev subscription or resource group.
</div>
<div>
Single Identities can be used to deploy across scopes or security boundaries.<br>
A Dev Management Group SP can deploy to multiple Dev Subscriptions and Resource Groups.
</div>
</div>
