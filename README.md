# Booklet könyváruház

# Az alkalmazás elindítása

## Fontos:

A nem amd64-es architektúrájú rendszereken a frontend elindításához szükséges Docker image build-elhető Dockerfile-ját (brownbas/sveltekit) a ./frontend/Dockerfile útvonalon lehet megtalálni és a következő paranccsal build-elni (ehhez a projekt gyökérkönyvtárában kell lennünk):

```bash
docker build -t brownbas/sveltekit ./frontend
```

A projekt Docker konténerekkel futtatható. Az alkalmazás elindításához a projekt gyökérkönyvtárában található `start.sh` szkriptet kell futtatni:

```bash
bash start.sh
```

A legelső futtatáskor érdemes az `--init` kapcsolót használni:

```bash
bash start.sh --init
```

Az `--init` kapcsolóval a rendszer az adatbázis feltöltését is elvégzi a seederek alapján.

A `start.sh` szkript működése:

- létrehozza a szükséges `.env` fájlokat, ha még nem léteznek
- létrehozza a Docker volume-okat az npm és composer csomagokhoz
- telepíti a frontend npm függőségeit
- elindítja a Docker konténereket
- telepíti a backend composer függőségeit
- lefuttatja az adatbázis migrációkat
- `-init` esetén lefuttatja az adatbázis seedelését
- létrehozza a Laravel alkalmazáskulcsot, ha még nincs

Az alkalmazás főbb Docker szolgáltatásai:

- frontend
- backend
- MySQL adatbázis
- phpMyAdmin
- Nginx proxy
- backend webserver

# Tesztelés

## Backend/API tesztek futtatása

A backend/API teszteléséhez be kell lépnünk a docker konténerbe

```bash
docker exec -it booklet-backend-1 fish
```

majd futtassuk az alábbi parancsot:

```bash
php artisan test
```

## Frontend E2E tesztek futtatása

A frontend teszteléséhez be kell lépnünk a docker konténerbe

```bash
docker exec -it booklet-frontend-1 fish
```

majd futtassuk az alábbi parancsot:

```bash
npx playwright test
# vagy
npm run test:e2e
```

Ha nem lennének letelepítve a szükséges függőségek, akkor ezt az alábbi paranccsal meg tudjuk tenni:

```bash
npx playwright install
```

# Bejelentkezési adatok

## Fontos:

Ha megváltoztatjuk a .env.example fájlban a DB_ROOT_PASSWORD környezeti változót az alkalmazás elindítása előtt, akkor a felhasználók jelszavai is megváltoznak. Ezek a belépési adatok csak abban az esetben pontosak, ha az alapértelmezett környezeti változókat használjuk.

## Customer/Vásárló szerepkör

Email cím: customer@customer.com

Jelszó: root_p_ssW0rd

## Staff/Alkalmazott szerepkör

Email cím: staff@staff.com

Jelszó: root_p_ssW0rd

## Manager/Menedzser szerepkör

Email cím: manager@manger.com

Jelszó: root_p_ssW0rd

## Admin/Adminisztrátor szerepkör

Email cím: admin@admin.com

Jelszó: root_p_ssW0rd

# Vásárlói kuponok tesztelése

A DatabaseSeeder-ben létrejön egy erre a célra használatos kupon, melyet csak is kizárólag a fentebb említett vásárló felhasználó tud felhasználni egyszer, ennek kuponkódja: **`COUPON10`**

# Dokumentációk

[Felhasználói dokumentáció](https://booklet-vizsgaremek.notion.site/Felhaszn-l-i-dokument-ci-34b2c3f166a18011981ad032806d4cf1)

[Fejlesztői dokumentáció](https://booklet-vizsgaremek.notion.site/Fejleszt-i-dokument-ci-34e2c3f166a180fda4d5d1c91b0b00fe)

# Egyéb hivatkozások

[Figma](https://www.figma.com/design/U5T1SfXa4n3uyMxSY71meJ/Booklet)

[Feladatok](https://booklet-vizsgaremek.notion.site/2ac2c3f166a180a2ad5bd5189e83f311)

[Tesztelési terv](https://www.notion.so/booklet-vizsgaremek/Test-plans-2b12c3f166a18049b596daa06002d7f2)

[Tesztelési jegyzőkönyv](https://booklet-vizsgaremek.notion.site/3432c3f166a18081b935fc70ef0d97c8)

# Forrásmegjelölés

A factory-kben (Például: BookFactory) található adatok többségének legenerálásához az Anthropic Claude AI Sonnet 4.6-os modelljét használtuk.

Néhány helyen kódkiegészítőként, illetve segédletként az alábbi MI modelleket alkalmaztuk, mint eszközt:

- Anthropic Claude Sonnet 4.6 és Claude Haiku 4.5 (Claude AI)
- OpenAI GPT-5.3 Instant és GPT-5.3 Codex (ChatGPT)
- Google Gemini 3.1 Pro
