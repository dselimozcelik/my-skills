# Selim'in AI-native backend çalışma sistemi

Bu repo bir eğitim kursu değil. Şirket bilgisayarına kurulan, gerçek backend task'larını teslim ederken aynı task'tan doğrulanmış öğrenme çıkaran taşınabilir bir skill paketidir.

Günlük kullanım, Windsurf/Copilot çağrıları, Digital Worker senaryosu, bug akışı, mastery güncellemesi ve sorun giderme için [KULLANIM_KILAVUZU.md](KULLANIM_KILAVUZU.md) dosyasını kullan.

Amaç şudur:

- AI implementasyonu hızlandırır; sen kritik akışı, mekanizmayı ve hata biçimini açıklayabilir hale gelirsin.
- Her plan adımı yalnızca o adım için gerekli kavramları öğretir; task ilerledikçe yeni kavramlar eklenebilir ama süreç geniş ve kopuk bir kursa dönüşmez.
- Önceden kanıtladığın konular tekrar sıfırdan anlatılmaz.
- Bir build'in yeşil olması ile senin konuyu öğrenmiş olman ayrı sonuçlar olarak raporlanır.
- Şirket kodu, repo yolu, müşteri verisi, schema, payload, credential veya production değeri kişisel öğrenme alanına yazılmaz.

## Pakette ne var?

| Skill | Görevi | Ne zaman kullanılır? |
| --- | --- | --- |
| `ai-native-task-tutor` | Gerçek task'ın teslimat ve öğrenme akışını birlikte yönetir. | Feature, bug, refactor veya review aldığında ana giriş noktasıdır. |
| `teach` | Global ustalık durumunu okur; ders seviyesini ayarlar ve yalnızca kanıtlanmış ilerlemeyi kaydeder. | Ana skill tarafından kullanılır veya özellikle stateful bir ders istediğinde çağrılır. |
| `diagnosing-bugs` | Önce hatayı görünür ve tekrarlanabilir yapan teşhis döngüsünü kurar. | Bug, exception, performans gerilemesi veya belirsiz failure olduğunda. |

`teach` ve `diagnosing-bugs`, Matt Pocock'un skill tasarımlarından alınmış veya uyarlanmıştır. Ayrıntılar [THIRD_PARTY.md](THIRD_PARTY.md) dosyasındadır. `agentic-learning` bu pakete eklenmedi; iyi fikirleri olsa da mevcut `teach` + `ai-native-task-tutor` ikilisiyle aynı öğrenme döngüsünü ikinci kez kurarak iki ayrı ilerleme kaynağı oluşturacaktı.

## Neden iki ayrı dizin var?

```text
GitHub'daki bu repo                 Şirket bilgisayarındaki kalıcı profil
skills/                             ~/.ai-learning/backend-engineering/
├── ai-native-task-tutor/           ├── MISSION.md
├── teach/                          ├── NOTES.md
└── diagnosing-bugs/                ├── MASTERY.md
                                    ├── GLOSSARY.md
                                    ├── RESOURCES.md
                                    ├── learning-records/
                                    └── sessions/
```

Skill kodu Git ile güncellenir. Kişisel öğrenme profili Git reposunun dışında büyür ve bootstrap tekrar çalıştırıldığında ezilmez.

Ortak global dizin olarak `~/.agents/skills` seçildi. Bu yol [Codex skill belgelerinde](https://developers.openai.com/codex/build-skills), [GitHub Copilot agent skill belgelerinde](https://docs.github.com/en/copilot/concepts/agents/about-agent-skills) ve [Windsurf Cascade skill belgelerinde](https://docs.windsurf.com/windsurf/cascade/skills) desteklenir. Windows karşılığı `%USERPROFILE%\.agents\skills` olur.

## Şirket bilgisayarına kurulum

Önce bu repoyu kendi GitHub hesabında tercihen **private** bir repo olarak tut. İçinde şirket kodu bulunmayacak olsa da kişisel çalışma biçimini ve öğrenme tercihlerini içeriyor.

Bu çalışma klasörünü yeni, boş bir GitHub reposuna ilk kez göndermek için:

```bash
git add .
git commit -m "Create AI-native backend learning workflow"
git remote add origin <GITHUB_REPO_URL>
git push -u origin main
```

Bu komutları ancak GitHub'da private ve boş repoyu oluşturduktan sonra çalıştır. Bu paket şirket bilgisayarına `clone` edilir; ürün repoları bunun içine kopyalanmaz.

### macOS / Linux

```bash
git clone <GITHUB_REPO_URL> selim-workspace-skills
cd selim-workspace-skills
bash scripts/bootstrap.sh
```

Varsayılan kurulum symlink kullanır. Böylece repo içinde `git pull` yaptığında skill'ler anında güncellenir.

Symlink kullanımı şirket politikası nedeniyle mümkün değilse:

```bash
bash scripts/bootstrap.sh --copy
```

Copy modunda sonraki güncellemede mevcut hedefin üzerine sessizce yazılmaz; eski kopyayı kontrollü biçimde kaldırıp bootstrap'ı yeniden çalıştırman gerekir.

### Windows PowerShell

```powershell
git clone <GITHUB_REPO_URL> selim-workspace-skills
Set-Location selim-workspace-skills
powershell -ExecutionPolicy Bypass -File .\scripts\bootstrap.ps1
```

PowerShell script'i varsayılan olarak directory junction kurar; çoğu Windows ortamında yönetici yetkisi veya Developer Mode gerektirmez. Junction yasaksa:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\bootstrap.ps1 -Mode copy
```

Kurulum iki şeyi yapar:

1. Üç skill'i `~/.agents/skills` altına bağlar veya kopyalar.
2. Eksikse global öğrenme profilini oluşturur; mevcut ilerleme dosyalarına dokunmaz.

Özel bir öğrenme konumu gerekiyorsa işletim sistemi ortam değişkeni tanımla:

```bash
export AI_LEARNING_HOME="$HOME/.ai-learning/backend-engineering"
```

```powershell
$env:AI_LEARNING_HOME = "$HOME\.ai-learning\backend-engineering"
```

Kurulumdan sonra kullandığın AI uygulamasını yeniden başlat. Şirket güvenlik politikası bu README'den üstündür: yalnızca onaylı modelleri ve araçları kullan.

## Her task'taki esas workflow

Ana çağrı aşağıdaki niyeti taşımalıdır:

```text
Bu task'ta ai-native-task-tutor skill'ini kullan.
Hemen implementasyona başlama. Önce repoyu inceleyip mevcut durumu,
istenen değişikliği, akışı ve acceptance criteria'yı benimle konuşarak netleştir.
Sonra her adımın gerekli konseptini, repo örneğini, implementasyonunu,
doğrulamasını ve öğrenme checkpoint'ini içeren bir plan çıkar.

Lokalde geliştiriyorsak her adımda anla → öğren → implement et → doğrula.
Digital Worker kullanıyorsak ona yalnızca implementasyon planını ver.
Değişiklikleri lokalime çektikten sonra gerçek diff'i adım adım bana öğret.
Kanıtladığım ilerlemeyi sanitize ederek global mastery profilime kaydet.
```

Hazır kopyala-yapıştır sürümü [prompts/task-start.md](prompts/task-start.md) dosyasındadır. Bunu her seferinde yazmamak için kullandığın onaylı AI aracının global rules/instructions alanına [prompts/global-rule.md](prompts/global-rule.md) içeriğini ekleyebilirsin.

Araçlara göre çağrı biçimi değişebilir:

- Codex: `$ai-native-task-tutor` yazarak veya skill adını açıkça söyleyerek.
- Windsurf: `@ai-native-task-tutor` ile.
- Copilot CLI: `/ai-native-task-tutor` ile. VS Code/JetBrains/cloud gibi diğer Copilot yüzeylerinde “use the ai-native-task-tutor skill” diyerek.
- Digital Worker: Skill veya öğrenme profili kullanmaz. Yalnızca [implementation handoff](skills/ai-native-task-tutor/references/digital-worker-handoff.md) içindeki normal teknik planı uygular.

Önce her iki yol için ortak bir anlayış ve plan kurulur:

```text
Task → repo keşfi → karşılıklı konuşma → ortak sistem modeli
     → acceptance criteria → implementasyon + öğrenme planı
```

Ardından iki çalışma modundan biri seçilir:

```text
LOKAL GELİŞTİRME
Plan adımı 1: repo örneği → konsept → checkpoint → implementasyon → test
Plan adımı 2: repo örneği → konsept → checkpoint → implementasyon → test
Plan adımı N: ...

DIGITAL WORKER
Anlaşılmış plan → worker one-shot implementasyon → branch/diff'i lokale çek
→ plan adımı 1'in gerçek diff'ini öğren/incele/doğrula
→ plan adımı 2'nin gerçek diff'ini öğren/incele/doğrula
→ plan adımı N'in gerçek diff'ini öğren/incele/doğrula
```

### 1. Önce sohbet ederek anlama

AI task metninden doğrudan kod yazmaya atlamaz. Repoyu inceler ve seninle kısa turlarla şunları netleştirir:

- şu anda sistem ne yapıyor;
- istek, veri, transaction veya mesaj hangi yoldan geçiyor;
- tam olarak ne değişecek ve ne scope dışında;
- benzer mevcut implementasyon nerede;
- kabul kriterleri ve muhtemel failure'lar neler;
- sonucu hangi test, build, log veya başka sinyal doğrulayacak.

Repodan bulunabilecek teknik bilgiyi senden istemez. Fakat iş kuralı veya tercih gibi repodan çıkarılamayan noktaları sana sorar. Plan, ikiniz de aynı problemi tarif edebilir hale gelince çıkarılır.

### 2. Implementasyon ve öğrenme planı

Planın her anlamlı adımında şunlar bulunur:

```text
Adım: Hangi davranış veya boundary değişecek?
Kod alanı: Hangi dosya/symbol etkilenebilir?
Konsept: Bu adımı anlamak için ne bilmem gerekiyor?
Repo örneği: Bunu mevcut kodun neresinden öğreneceğiz?
Implementasyon: Ne yapılacak?
Doğrulama: Hangi focused test/check çalışacak?
Checkpoint: Ben neyi açıklayınca bu adım anlaşılmış sayılacak?
```

Planlama da dersin parçasıdır. AI, adımların neden o sırada olduğunu ve hangi teknik bağımlılığın bu sırayı zorunlu kıldığını anlatır.

### 3A. Lokalde geliştirme

Windsurf/Copilot ile her plan adımı ayrı işlenir:

1. Mevcut repo örneğine bakılır.
2. AI, kodun ne yaptığını düşündüğünü sorar.
3. Eksik konsept `teach` ile o kod üzerinden öğretilir.
4. Sen kritik bağlantıyı açıklarsın veya tahmin edersin.
5. O plan adımı implement edilir.
6. Focused test/check çalıştırılır ve neyi kanıtlamadığı da konuşulur.
7. End-to-end akış güncellenir, sonraki adıma geçilir.

Bütün Spring'i baştan öğrenip sonra task'a dönmezsin. İhtiyacın olan Spring parçasını, ihtiyaç duyduğun implementasyon adımının hemen önünde öğrenirsin.

### 3B. Digital Worker ile geliştirme

Digital Worker'a öğretici görev verilmez. Ondan quiz, mastery değerlendirmesi, kavram listesi veya ders raporu istenmez. Worker'a yalnızca daha önce birlikte çıkardığınız uygulanabilir plan, acceptance criteria, scope ve normal test/build beklentileri verilir.

Worker bitirince:

1. Branch veya değişiklikler lokal repoya çekilir.
2. Windsurf/Copilot gerçek diff'i okur; worker özetine güvenmez.
3. Değişen hunk'lar önceden hazırlanmış plan adımlarıyla eşleştirilir.
4. Plandan sapmalar, ekstra değişiklikler ve eksikler belirlenir.
5. Her plan adımı için repo örneği ve ilgili konsept öğretilir.
6. O adıma ait diff tek tek incelenir ve lokal doğrulama çalıştırılır.
7. Sen değişikliğin ne yaptığını açıklayınca adım anlaşılmış sayılır.

Burada ders yüzeyi worker'ın sonradan lokale çekilmiş gerçek kodudur. Öğretmen Windsurf/Copilot, implementasyon motoru Digital Worker'dır.

### 4. Mastery seviyesi

`MASTERY.md` seviyesi başlangıç noktasını belirler:

- `0 — unverified`: Konu beginner kabul edilir ve minimum prerequisite zinciri anlatılır.
- `1 — explain`: Kısa hatırlatma yapılır, sonra mevcut kodda uygulama istenir.
- `2 — apply`: Önce kısa transfer sorusu sorulur; doğruysa tekrar ders verilmez.
- `3 — debug/review/teach`: Daha zor failure/review sorusu ile kanıt aranır.

Örneğin task `@Bean` içeriyorsa tüm Spring kursuna gidilmez. Önce container ownership ve dependency injection gerekiyorsa bunlar, sonra mevcut `@Bean` metodunun bu repodaki etkisi ele alınır.

### 5. Son sentez

Her adımda zaten checkpoint bulunduğu için sonda ikinci bir büyük kurs yapılmaz. AI yalnızca bütün değişikliği birbirine bağlayan üç soruyu sırayla sorar:

1. **Flow:** İstek/veri/mesaj değişen koddan nasıl geçiyor?
2. **Mechanism:** Kritik Java/Spring/SQL/Kafka mekanizması burada neden böyle davranıyor?
3. **Failure:** Gerçekçi bir failure nedir ve hangi test/log/metric bunu gösterir?

Eksik cevapta AI yalnızca boşluğun bulunduğu plan adımını yeniden açar. Daha önce gösterdiğin diğer kavramları baştan anlatmaz.

### 6. İki ayrı sonuç

Her task şu iki satırla kapanır:

```text
Delivery: implemented / partially implemented / blocked
Learning: passed / in progress
```

Yeşil build yalnızca Delivery için kanıttır. “Anladım” demen yalnızca Learning için kanıt değildir; kendi cümlenle açıklama veya farklı örneğe transfer gerekir.

## İlerlemenin tekrar anlatmayı önlemesi

`MASTERY.md` yalnızca sen kanıt verdiğinde ilerler. Her satırda seviye, tarih, sanitize edilmiş kanıt ve bir sonraki ispat bulunur. Sonraki task'ta AI bu dosyayı okur:

- kanıtlanmamış konuya beginner seviyesinden girer;
- daha önce uyguladığın konu için önce retrieval/transfer sorusu sorar;
- cevabın nedenselse açıklamayı atlar;
- boşluk varsa yalnızca eksik bağlantıyı yeniden öğretir.

Bu yüzden profil “hangi videoları izledim?” listesi değil, “hangi yeteneği hangi davranışla gösterdim?” kaydıdır.

## Güvenlik sınırı

Global profile veya bu GitHub reposuna şunları yazma:

- şirket/repo/servis adları ve yerel repo yolları;
- source code, internal schema veya gerçek payload;
- müşteri ya da çalışan verisi;
- credential, token, endpoint veya production değeri;
- şirket içi mimariyi açığa çıkaracak ayrıntı.

Uygun kayıt şuna benzer: “Proxied transaction sınırının self-invocation ile atlanabileceğini açıklayıp test sinyalini belirledi.” Uygun olmayan kayıt gerçek class, repo, müşteri veya tablo adlarını içerir.

## Güncelleme

Symlink/junction kurulumunda:

```bash
git pull --ff-only
```

yeterlidir. Öğrenme profili repo dışında olduğu için güncellemeden etkilenmez. Skill davranışını değiştirdiğinde önce bu repoda review et; şirket bilgisayarında körlemesine üçüncü taraf güncellemesi çekme.
