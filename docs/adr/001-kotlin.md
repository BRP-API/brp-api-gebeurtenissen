# ADR 001: BRP API Gebeurtenissen wordt in Kotlin geschreven

# Status
Voorstel

## Context

De keuze voor de programmeertaal staat open voor BRP API Gebeurtenissen. Een deel van het team programmeert in C# terwijl een ander deel programmeert in Java. Daarnaast is Java de dominante taal binnen RvIG.

## Beslissingen

De keuze valt op Kotlin, omdat het een aantal grote voordelen heeft ten opzichte van Java:

1. **null safety**: `NullPointerException` fouten worden voorkomen door nullability in het type system op te nemen. De ontwikkelaar wordt gedwongen om null cases goed te werken en wordt hierbij geholpen door de compiler en handige language features zoals null coalescing en smart type casting.
2. **interoperability**: Kotlin is 100% interoperable met Java. Dat betekent dat Kotlin code in staat is om Java code aan te roepen en andersom. Beide talen worden gecompileerd naar Java bytecode waarna het wordt gerund in de JVM. Hierdoor blijft de tooling en ecosysteem die men in Java gewend zijn hetzelfde. Ook kan men hierdoor stapsgewijs migreren van de ene naar de andere taal.
3. **ops blijft hetzelfde**: Kotlin draait op de JVM, net als Java. Hierdoor hoeft het ops team niets te doen om de stap naar Kotlin te faciliteren.
4. **upgradability**: Kotlin heeft een eigen upgrade pad, los van Java. Hierdoor is het team onafhankelijk van de Java (JVM) versie die het ops team hanteert.
5. **overgang van C#**: een deel van ons team komt uit de wereld van C#. Kotlin heeft meer language features die overeenkomen met C#, zoals null coalescing en extension functions, waardoor ontwikkelaars kunnen blijven programmeren zoals ze zijn gewend.
6. **functional programming support**: Kotlin ondersteunt meer functional programming features, zoals first-class functions, betere lambda expressions, en collection operators.
7. **type systeem**: Kotlin heeft meer language features rondom het type systeem. Zo is het bijvoorbeeld mogelijk om een `typealias` te introduceren. Gecombineerd met extension functions en functional programming support leidt dit tot korte maar expressieve code.
8. **developer productivity**: samenvattend maakt Kotlin het mogelijk om kortere, expressievere en veiligere code te schrijven, wat bijdraagt aan de productiviteit van ontwikkelaars.
9. **reputatie**: Google heeft Kotlin omarmd als de hoofdtaal voor Android. Dat betekent dat alle (moderne) Android apps vandaag de dag in Kotlin worden geschreven. Verder heeft Kotlin ook een sterke reputatie binnen de Java community. 
