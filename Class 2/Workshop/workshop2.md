### Workshop #2

# HelloSwift 2

### Opis zadania

Celem zadania znowu jest rozwiązanie dwóch małych zadań.

#### Factorization

Pierwsze polega na stworzeniu klasy sprawdzającej czy podana liczba jest liczbą pierwszą. czy złożoną. Do tego celu wykorzystamy swiftowe `enum`y. Chcemy żeby wywołanie naszej klasy wyglądało w ten sposób:

```swift
let result = Factorization.factorize(5)
print(result)
// prints: Optional(Workshop2.Factorization.Result.prime)
```

Jak widać w powyższego `print`u – metoda `factorize` zwraca `Optional<Result>`, czyli `Result?`. Dlaczego wykorzystaliśmy typ `Optional`? Niektóre liczby całkowite nie kwalifikują się ani jako pierwsze, ani jako złożone. Wtedy chcemy, żeby funkcja zwróciła `nil`.

W przypadku liczby złożonej funkcja `factorize` zwraca inną opcję z enuma `Result`. Ta opcja zawiera **associated value** będące tablicą dzielników (ułożone niemalejąco czynniki pierwsze z rozkładu parametru).

```swift
Factorization.factorize(1) == nil
Factorization.factorize(5) == .prime
Factorization.factorize(6) == .composite(factors: [2, 3])
Factorization.factorize(8) == .composite(factors: [2, 2, 2])
Factorization.factorize(2 * 2 * 5 * 11 * 13) == .composite(factors: [2, 2, 5, 11, 13])
```

#### Memory Management + Structs

Drugie zadanie to stworznie prostej hierarchii dwóch **klas**. Pierwsza klasa to klasa `Person`, zawierająca stałą `name: String` oraz opcjonalnie samochód (`Car`). Druga klasa to klasa `Car` zawierająca markę (marka + model) oraz (opcjonalnie) właściciela (`Person`).

`Person` ma metodę służącą do kupowania samochodu.

Przykładowe użycie hierarchii wygląda następująco:

```swift
let model = Car.Model(mark: "Porsche", model: "911")
let car = Car(model: model)
let person = Person(name: "Piotr")
person.buy(car: car)
```

### Wskazówki

1. W pierwszym zadaniu jako rezultatu użyj odpowiedniego [*enum*](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
2. Pamiętaj, żeby opcji `Result.composite` dać **associated value** – `factors: [Int]`.
3. Typ `Result` umieść jako wewnętrzny typ klasy `Factorization` – taki jest pattern w Swifcie, zamiast tworzyć wiszący enum `FactoriationResult`.
4. Podpowiedź: aby móc porównywać do siebie struktury, musisz oznaczyć conformance do protokołu `Equatable`.
5. Napisz poprawne nagłówek funkcji `factorize`. Użyj funkcji statycznej (obiekt `Factorization` nie ma stanu wewnętrznego).
6. W zadaniu 2 zastanów się, gdzie użyć *klasy*, a gdzie *struktury*. Podpowiedź: _będziesz potrzebował obu_.
7. `Car.Model` to (jak widać) typ wewnętrzny dla `Car` 😉
8. Zwróć uwagę, żeby nie wygenerować wycieków pamięci w zadaniu 2.
9. Znowu skorzystaj z targetu typu *Cocoa Touch Library*.
10. Tym razem nie udostępniam wszystkich testów jednostkowych, które będą służyły do sprawdzenia zadania. Poniżej umieszczam kilka – (musisz też sam sobie poradzić z uruchomieniem ich).

```swift
func testFactorsOf1() {
  XCTAssertNil(Factorization.factorize(1))
}

func testFactorsOf2() {
  XCTAssertEqual(Factorization.factorize(2), .prime)
}

func testFactorsOf4() {
  XCTAssertEqual(Factorization.factorize(4), .composite(factors: [2, 2]))
}

func testBuyApi() {
  let model = Car.Model(mark: "Porsche", model: "911")
  let car = Car(model: model)
  let person = Person(name: "Michał")
  person.buy(car: car)
  XCTAssertTrue(car === person.car)
  XCTAssertTrue(car.owner === person)
}
```

11. Jako rozwiązanie prześlij *cały projekt XCode*. Pamiętaj, żeby dodać do projektu odpowiedni plik [`.gitignore`](https://www.gitignore.io/api/swift,xcode,macos).

### Kryteria oceny

1. Poprawnie stworzony projekt typu Cocoa Touch Framework.
2. Przechodzące wszystkie testy.
3. Brak wycieków pamięci.
4. Poprawnie użyty enum z associated value
5. Styl kodu.
6. Spełnienie warunków API
7. Umieszczenie klas w osobnych, poprawnie nazwanych plikach.
8. Poprawnie stworzone repozytorium w projekcie, poprawnie stworzony commit kodu, dodany plik .gitignore.

### Odpowiedzi

Odpowiedź (cały, spakowany w .zip folder projektu) wyślij mailem na adres [email](mailto:ios@daftacademy.pl) do końca najbliższej soboty: **24.11.2018, 23:59**.

Przypominam, że jest możliwość wykonania zadania w salce na MiMUW. Termin to **środa w godzinach 16:00 - 18:00**. Przyjdźcie w tym terminie – administratorzy uruchomią Wam system i będziecie mogli wykonać zadanie.
