# Skill kullanım kılavuzu

Bu kılavuz, gerçek bir backend task'ı geldiğinde `ai-native-task-tutor`, `teach` ve `diagnosing-bugs` skill'lerinin Windsurf, GitHub Copilot ve Digital Worker ile nasıl kullanılacağını anlatır.

Sistemin temel cümlesi:

```text
Önce lokal repo üzerinde problemi anla ve planla.
Sonra implementasyon yöntemini seç.
Her anlamlı adımı repo üzerinden öğren ve doğrula.
Yalnızca gösterdiğin yeteneği global profile kaydet.
```

## En kısa kullanım

1. Ürün reposunu Windsurf veya Copilot'ta aç ve birini lead tutor seç.
2. `ai-native-task-tutor` skill'ini task metniyle açıkça çağır.
3. “Keşif modunda kal; planı onaylamadan kod değiştirme” de.
4. Ortak sistem modeli ve implementasyon + öğrenme planı çıkınca lokal geliştirme veya Digital Worker yolunu seç.
5. Lokal yolda her adımı öğrenip implement et; worker yolunda sonucu çekip gerçek diff'i her plan adımı üzerinden öğren.
6. Son sentezi cevapla; Delivery ve Learning sonuçlarını ayrı kapat; yalnızca kanıtlanan mastery'yi kaydet.

## 1. Araçların görev dağılımı

| Aktör | Asıl görevi | Yapmaması gereken |
| --- | --- | --- |
| Selim | İş bağlamını tamamlamak, sorular sormak, tahmin yapmak ve kritik mekanizmaları kendi cümlesiyle açıklamak | AI çıktısını okumadan veya doğrulamadan kabul etmek |
| Lead tutor: Windsurf **veya** Copilot | Repoyu incelemek, sohbeti yürütmek, planı çıkarmak, `teach` ile öğretmek, adımları doğrulamak ve mastery güncellemek | Task metninden doğrudan implementasyona atlamak |
| İkinci lokal AI aracı | Gerekirse bağımsız açıklama, küçük implementasyon yardımı veya ikinci review sağlamak | Aynı task'ta lead tutor'dan bağımsız mastery güncellemek |
| Digital Worker | Üzerinde anlaşılmış teknik planı one-shot implement etmek | Ders vermek, quiz yapmak, seviyeni ölçmek veya learning profile yazmak |

Her task için Windsurf veya Copilot'tan birini **lead tutor** seç. Lead tutor task sohbetinin, öğrenme checkpoint'lerinin ve `MASTERY.md` güncellemesinin sahibidir. Diğer aracı kullanırsan ona açıkça “mastery dosyasını değiştirme” de.

## 2. Üç skill ne zaman çalışır?

### `ai-native-task-tutor`

Her feature, refactor, code review veya bug task'ında ana giriş noktasıdır. Şunları yönetir:

- mevcut sistemi repo üzerinden anlama;
- seninle soru-cevaplı task keşfi;
- implementasyon ve öğrenme planı;
- lokal geliştirme veya Digital Worker yolunun seçilmesi;
- her plan adımının öğrenilmesi ve doğrulanması;
- son sentez ve iki ayrı kapanış: Delivery / Learning.

### `teach`

`ai-native-task-tutor` tarafından ihtiyaç oldukça çağrılan öğretme ve kalıcı ilerleme motorudur. Her gün ayrıca çağırman gerekmez. Şunları yapar:

- global `MISSION.md`, `NOTES.md` ve `MASTERY.md` dosyalarını okur;
- mevcut seviyene göre dersin başlangıç noktasını seçer;
- önce tahmin veya retrieval sorusu sorar;
- yalnızca eksik nedensel bağlantıyı repo örneğiyle öğretir;
- farklı örnekle transferi kontrol eder;
- kanıt varsa mastery seviyesini günceller.

Belirli bir kavramı task dışında ayrıca çalışmak istersen doğrudan `teach` çağırabilirsin. Normal task akışında ana skill'in onu çağırması daha doğrudur.

### `diagnosing-bugs`

Task bir bug, exception, flaky davranış veya performans gerilemesiyse ana skill'in içinde devreye girer. Önce bug'ı yakalayan hızlı ve kırmızıya dönebilen bir feedback loop kurar; sonra reproduce, minimize, hipotez, instrumentation, fix, regression ve cleanup aşamalarını izler.

Bu skill “koda bakıp muhtemelen şudur” yaklaşımını engeller. Bug'ı yakalayan bir komut veya ölçüm kurulmadan root-cause iddiası üretmez.

## 3. Kurulumun çalıştığını doğrulama

Bootstrap tamamlandıktan sonra global skill dizininde şu üç klasör bulunmalıdır:

```text
~/.agents/skills/
├── ai-native-task-tutor/
├── teach/
└── diagnosing-bugs/
```

Her birinin içinde `SKILL.md` bulunmalıdır. Kalıcı öğrenme alanı da şurada olmalıdır:

```text
~/.ai-learning/backend-engineering/
├── MISSION.md
├── NOTES.md
├── MASTERY.md
├── GLOSSARY.md
├── RESOURCES.md
├── learning-records/
├── sessions/
└── reference/
```

Kurulumdan sonra Windsurf veya Copilot'u yeniden başlat. Skill görünmüyorsa önce dosya yollarını ve `SKILL.md` adının büyük harflerle doğru yazıldığını kontrol et.

Windsurf resmi olarak `~/.agents/skills` dizinini cross-agent uyumluluğu için tarar ve bir skill'i `@skill-name` ile manuel çağırmayı destekler. GitHub Copilot da `~/.agents/skills` dizinini kişisel skill konumu olarak destekler. Copilot CLI'da `/skills list`, `/skills info NAME`, `/skills reload` komutları ve `/SKILL-NAME` çağrısı kullanılabilir. Kaynaklar: [Windsurf Cascade Skills](https://docs.windsurf.com/windsurf/cascade/skills), [GitHub Copilot agent skills](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills), [Copilot CLI reference](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-command-reference).

## 4. Windsurf'te kullanım

### Skill'i çağırma

Cascade girişine şunu yaz:

```text
@ai-native-task-tutor

[Task metni]

Önce keşif modunda kal. Kod değiştirme. Mevcut sistemi ve istenen değişikliği
repo üzerinden benimle konuşarak netleştir. Sonra implementasyon + öğrenme
planını çıkar; planı onaylamadan implementasyona geçme.
```

Windsurf açıklamadan skill'i otomatik de seçebilir. Gerçek task'larda davranışın kesin olması için `@ai-native-task-tutor` ile açık çağrı tercih edilir.

Bug task'ında başlangıç:

```text
@ai-native-task-tutor @diagnosing-bugs

[Bug açıklaması ve gözlenen belirti]

Önce bug'ın tam belirtisini ve onu yakalayacak red-capable feedback loop'u
kur. Root-cause hipotezine bundan önce geçme. Öğrenme adımlarını mastery
profilime göre yürüt.
```

### Windsurf'te bir task oturumu

1. İlgili ürün reposunu workspace olarak aç.
2. Cascade'de yeni bir konuşma başlat.
3. `@ai-native-task-tutor` ile task metnini gönder.
4. AI'nın repo keşfi yapmasına izin ver; ilk aşamada edit yaptırma.
5. Mevcut akışı kendi cümlenle geri anlat.
6. Implementasyon + öğrenme planını incele ve gerekirse değiştir.
7. Lokal geliştirme seçildiyse her adımı ayrı yürüt.
8. Digital Worker seçildiyse handoff metnini al, worker'a ver ve sonuç dönene kadar lokal task oturumunu koru.
9. Task sonunda son sentezi yap ve yalnızca kanıtlanan mastery değişikliklerini kaydettir.

## 5. GitHub Copilot'ta kullanım

GitHub'ın resmi belgelerine göre agent skills; Copilot cloud agent, code review, Copilot CLI, Copilot app ve VS Code/JetBrains agent mode içinde kullanılabilir. Yüzeye göre açık çağırma biçimi değişebilir.

### Copilot CLI

Skill'leri kontrol et:

```text
/skills list
/skills info ai-native-task-tutor
/skills info teach
/skills info diagnosing-bugs
```

Yeni kurulum veya skill güncellemesinden sonra:

```text
/skills reload
```

Task'ı başlat:

```text
/ai-native-task-tutor

[Task metni]

Önce repoyu incele ve benimle mevcut davranışı konuş. Kod değiştirme.
Planın her anlamlı adımına gerekli konsepti, repo örneğini, doğrulamayı ve
learner checkpoint'ini ekle. Planı onaylamadan implementasyona başlama.
```

### VS Code, JetBrains veya diğer Copilot agent yüzeyleri

Bu yüzeylerde slash-skill davranışını varsayma. Copilot skill'i açıklamasından otomatik seçebilir; garanti etmek için doğal dille açıkça söyle:

```text
Use the ai-native-task-tutor skill for this task.

[Task metni]

Stay in discovery mode first. Inspect the repository, discuss the current and
desired flow with me, and produce the implementation-and-learning plan before
editing code.
```

Copilot'un gerçekten skill davranışını izlediğini şu işaretlerden anlarsın:

- hemen edit yapmak yerine mevcut akışı araştırır;
- `MASTERY.md` seviyeni okur;
- plan adımlarına concept, repo example, verification ve checkpoint ekler;
- öğrenme sorularını birer birer sorar;
- Delivery ve Learning sonuçlarını ayrı kapatır.

Bunları yapmıyorsa “skill yüklendi mi?” tartışmasına girmek yerine skill adını tekrar açıkça belirt ve şu cümleyi ekle:

```text
Before proceeding, summarize the operating contract from the installed
ai-native-task-tutor skill and tell me which phase we are in.
```

## 6. Opsiyonel global davranış kuralı

Skill ayrıntılı task prosedürüdür; [global-rule.md](prompts/global-rule.md) ise “feature/bug task'larında bu prosedürü hatırla” diyen kısa, sürekli davranış kuralıdır. Global rule zorunlu değildir ama her task'ta aynı başlangıç prompt'unu yazma ihtiyacını azaltır.

### Windsurf

Cascade → Customizations → Rules → `+ Global` yolunu aç ve `prompts/global-rule.md` içeriğini ekle. Windsurf'ün global rules dosyası `~/.codeium/windsurf/memories/global_rules.md` konumundadır ve her workspace'te aktiftir. Mevcut global kuralları silme; yeni metni çelişmeyecek şekilde birleştir. Resmi kaynak: [Windsurf Memories and Rules](https://docs.windsurf.com/windsurf/cascade/memories).

### Copilot CLI

Copilot CLI kişisel talimatları `$HOME/.copilot/copilot-instructions.md` dosyasından yükler. Varsa mevcut içeriği koruyarak `prompts/global-rule.md` metnini ekle. Aktif oturumda hangi talimatların yüklendiğini görmek için:

```text
/instructions
```

Talimat değişikliğinden sonra yeni bir oturum başlat veya mevcut oturumu kapatıp devam ettir. Resmi kaynak: [Copilot CLI custom instructions](https://docs.github.com/en/enterprise-cloud@latest/copilot/how-tos/copilot-cli/customize-copilot/add-custom-instructions).

### Copilot IDE

JetBrains veya desteklenen başka bir IDE'de Copilot Chat → Settings/Customizations alanından personal instructions bölümünü kullan. Kurumsal policy kişisel talimatları kapatmışsa global rule kurmaya çalışma; task başında açık skill invocation kullan.

Global rule, skill içeriğini kopyalayan ikinci bir prosedür olmamalıdır. Yalnızca ana skill'i ne zaman kullanacağını ve Digital Worker'ın öğretmen olmadığını hatırlatmalıdır.

## 7. Ortak başlangıç: keşif ve planlama

Windsurf, Copilot veya daha sonra Digital Worker kullanılacak olması fark etmez. Her task önce lokal lead tutor ile bu aşamadan geçer.

### Keşif modunda AI'nın yapacakları

- task metnini davranışa çevirmek;
- en küçük ilgili repo alanını bulmak;
- benzer mevcut implementasyonu bulmak;
- request, data, transaction veya message flow'u çıkarmak;
- acceptance criteria ve scope dışını ayırmak;
- failure yollarını ve doğrulama komutlarını belirlemek;
- repo kanıtı ile çıkarımı ayrı göstermek.

### Senin yapacakların

- repodan çıkarılamayan iş kuralını açıklamak;
- anlamadığın kavramı o anda sormak;
- AI'nın mevcut sistem anlatımını kendi cümlenle geri kurmak;
- planın task metniyle uyuşup uyuşmadığını kontrol etmek;
- lokal geliştirme mi Digital Worker mı kullanılacağına plan çıktıktan sonra karar vermek.

### Planın zorunlu biçimi

Her anlamlı adım şu alanlara sahip olmalı:

```text
Adım:
Davranış/boundary:
Kod alanı:
Neden bu sırada:
Öğrenilecek konsept:
Repo içindeki öğretici örnek:
Implementasyon:
Focused doğrulama:
Selim checkpoint'i:
```

Plan yalnızca dosya listesi veriyorsa eksiktir. Şunu söyle:

```text
Planı ai-native-task-tutor formatında yeniden yaz. Her adıma gerekli konsepti,
repo örneğini ve benim açıklamam gereken checkpoint'i ekle.
```

## 8. Senaryo A — Windsurf/Copilot ile lokal geliştirme

Plan onaylandıktan sonra lead tutor'a söyle:

```text
Lokal iterative mode'a geç. Yalnızca Plan Adımı 1'i aç.
Önce mevcut repo örneğini göster, sonra tahminimi sor.
Teach checkpoint'ini geçmeden bu adımın implementasyonuna başlama.
```

Her adımın ritmi:

```text
Orient
  Mevcut repo örneği ve değişecek boundary
       ↓
Retrieve
  "Sence bu kod ne yapıyor / ne olur?"
       ↓
Teach
  Eksik nedensel bağlantının küçük dersi
       ↓
Checkpoint
  Senin açıklaman veya tahminin
       ↓
Implement
  Yalnızca bu plan adımının focused diff'i
       ↓
Verify
  Test/build/log ve bunun kanıtlamadığı şey
       ↓
Connect
  Güncel end-to-end flow ve sonraki adım
```

AI bir adımda çok fazla teori açarsa:

```text
Bu adım için yalnızca implementasyonu anlamamı ve doğrulamamı engelleyen
prerequisite'leri tut. Diğer konuları next-proof veya ileride öğrenilecekler
olarak kaydet; şimdi anlatma.
```

AI sen cevap vermeden ilerlerse:

```text
Bu adımın learner checkpoint'ini ben geçmedim. Implementasyonu durdur,
soruyu birer birer sor ve cevabı benim yerime verme.
```

Focused doğrulama çalışınca şu iki sorunun cevabını iste:

```text
Bu kontrol tam olarak neyi kanıtladı?
Bu kontrol geçse bile hâlâ ne yanlış olabilir?
```

## 9. Senaryo B — Digital Worker one-shot implementasyon

Digital Worker kullanımı üç bölümdür: pre-dispatch, worker çalışması ve lokal diff öğrenme.

### Bölüm 1: Pre-dispatch

Önce lokal lead tutor ile keşif ve planlama tamamlanır. Sen en azından şunları açıklayabilmelisin:

- sistem şu anda ne yapıyor;
- task neyi değiştirecek;
- plan adımları neden bu sırada;
- worker'ın dokunacağı ana boundary'ler;
- kabul kriterleri.

Ardından lead tutor'a söyle:

```text
Digital Worker mode'u seçiyorum. Öğrenme talimatlarını worker prompt'una
koyma. Üzerinde anlaştığımız planı yalnızca Goal, Current Behavior,
Acceptance Criteria, Implementation Plan, Scope/Constraints ve Validation
başlıklarıyla uygulama handoff'una dönüştür.
```

Worker'a verilen prompt'ta şunlar bulunmamalı:

- bana kavram öğret;
- seviyemi ölç;
- quiz yap;
- mastery dosyası güncelle;
- öğrenme raporu üret;
- task'ı pedagojik adımlarda durdur.

Worker'a verilen teknik şablon: [digital-worker-handoff.md](skills/ai-native-task-tutor/references/digital-worker-handoff.md).

Task bir bug ise Digital Worker'a fix göndermeden önce lokal `diagnosing-bugs` akışında exact symptom ve red-capable feedback loop belirlenmiş olmalı. Aksi halde worker'a doğrulayamayacağı bir root-cause tahmini verilmiş olur.

### Bölüm 2: Worker çalışırken

Worker one-shot implementasyon yapar. Bu sırada lokal lead tutor konuşmasını mümkünse açık tut. Task planı, kararlar ve başlangıçtaki sistem modeli burada bulunur.

Worker'ın “başarılı”, “build green” veya “task complete” demesi öğrenme ya da bağımsız doğrulama değildir. Bunlar yalnızca lokal incelemeye giriş bilgisidir.

### Bölüm 3: Değişiklikleri lokale çekme

Önce mevcut çalışma ağacını kontrol et:

```bash
git status --short
```

Ardından takımınızın normal ve onaylı Git akışıyla worker branch'ini getir. Genel örnek:

```bash
git fetch origin
git switch <worker-branch>
git diff <base-branch>...HEAD
```

Branch adı ve base branch gerçek task'tan alınmalıdır; tahmin edilmemelidir. Lokal uncommitted değişiklik varsa switch/merge öncesinde normal takım prosedürünü uygula.

Sonra Windsurf veya Copilot'ta [digital-worker-review.md](prompts/digital-worker-review.md) prompt'unu kullan.

Lead tutor şunları yapmalı:

1. Gerçek diff'i ve mevcut repo durumunu okumalı.
2. Her changed hunk'ı plan adımlarından birine bağlamalı.
3. Planda olmayan değişiklikleri ayrı göstermeli.
4. Planlanıp yapılmamış davranışları göstermeli.
5. Worker'ın getirdiği yeni bağımlılık veya kavramları belirlemeli.
6. Her plan adımını ayrı ayrı öğretmeli ve inceletmeli.
7. Lokal testleri çalıştırmalı.
8. Spec ve repository standards değerlendirmesini ayrı yapmalı.

Her worker adımındaki ritim:

```text
Plan adımı → gerçek diff hunk'ı → mevcut repo karşılığı → gerekli konsept
→ senin açıklaman → lokal verification → akışa bağlama
```

Worker diff'i çok büyükse dosya dosya rastgele gezme. Önce plan adımlarına ve davranış boundary'lerine böl. Bir dosya birden fazla davranış adımına hizmet edebilir.

Worker sonucu eline plan sohbeti yapılmadan geldiyse kurtarma yolu şudur:

1. Task/ticket metninden beklenen davranışı çıkar.
2. Base branch ile worker branch arasındaki gerçek diff'i oku.
3. Değişiklik öncesi ve sonrası akışı repodan yeniden kur.
4. Diff'ten geriye doğru geçici implementasyon planı oluştur.
5. Bu planı “reconstructed plan” olarak açıkça işaretle; worker'ın niyetini gerçek kabul etme.
6. Normal diff replay döngüsünü adım adım uygula.

## 10. Senaryo C — Bug veya performans problemi

Başlangıçta ana skill ile diagnosis skill'ini birlikte çağır:

```text
@ai-native-task-tutor @diagnosing-bugs

[Beklenen davranış]
[Gözlenen davranış]
[Varsa hata mesajı, tekrar koşulları ve zaman bilgisi]

Önce bug'ın birebir belirtisini yakalayan red-capable feedback loop kur.
Feedback loop oluşmadan root-cause hipotezi veya fix üretme.
Her diagnosis aşamasındaki gerekli konsepti teach ile repo üzerinden öğret.
```

Copilot CLI karşılığı:

```text
/ai-native-task-tutor

Use the diagnosing-bugs skill inside this task. [Bug details...]
```

Beklenen sıra:

1. Secret ve kişisel veriler redakte edilir.
2. Bug'ı yakalayan bir test, curl, script, trace replay veya ölçüm kurulur.
3. Reproduction hızlandırılır ve mümkünse deterministik yapılır.
4. Senaryo küçültülür.
5. Üç ila beş yanlışlanabilir hipotez sıralanır.
6. Tek değişkenli probe veya instrumentation uygulanır.
7. Doğru seam varsa regression testi önce kırmızı görülür.
8. Fix uygulanır.
9. Hem minimal regression hem orijinal repro yeniden çalıştırılır.
10. Debug instrumentation temizlenir.

Bu süreçte `teach`, örneğin transaction proxy, exception propagation, Kafka offset, SQL planı veya concurrency gibi root-cause'u anlayabilmen için gereken kavramı mevcut bug akışı üzerinden öğretir.

## 11. Senaryo D — Windsurf ve Copilot'u aynı task'ta birlikte kullanma

İkisini birlikte kullanabilirsin ama tek lead tutor kuralını koru.

Örnek rol dağılımı:

```text
Windsurf:
  Lead tutor, task sohbeti, plan, lokal step loop, mastery update

Copilot:
  Belirli bir diff için second opinion veya küçük implementasyon yardımı
  Mastery dosyasına yazmaz

Digital Worker:
  Gerekirse one-shot implementasyon
```

Copilot'a ikinci görüş verirken:

```text
Bu task'ta lead tutor Windsurf. MASTERY.md, learning-records veya sessions
dosyalarını değiştirme. Yalnızca şu diff'in davranış, failure ve repository
standards açısından bağımsız review'unu yap: [...]
```

Araç değiştirmek zorundaysan yeni lead tutor'a şunları ver:

- task metni;
- onaylanmış plan;
- tamamlanan plan adımları;
- çalışan doğrulamalar;
- açık riskler;
- sıradaki learner checkpoint.

Yeni araç repo detaylarını kendisi yeniden doğrulamalı. Önceki AI özetini kanıt kabul etmemeli.

## 12. Mastery nasıl güncellenir?

Mastery seviyeleri:

| Seviye | Anlamı | Örnek kanıt |
| --- | --- | --- |
| `0 — unverified` | Henüz davranış kanıtı yok | Yalnızca kavramın adı duyuldu |
| `1 — explain` | Merkezi mekanizmayı kendi cümlenle açıklayabiliyorsun | Spring container'ın dependency'yi nasıl bağladığını açıkladın |
| `2 — apply` | Gerçek task'ta uygulayıp doğrulayabiliyorsun | Doğru boundary'yi seçip test sinyalini savundun |
| `3 — debug/review/teach` | Failure teşhis ediyor, başka çözümü review ediyor veya transfer ediyorsun | Proxy kaynaklı transaction failure'ını kanıtla teşhis ettin |

Seviye yükseltmeyen şeyler:

- AI'nın kod yazması;
- worker build'inin geçmesi;
- açıklamayı okuman;
- “anladım” demen;
- aynı cevabı metinden tekrar etmen.

Seviye yükseltebilecek şeyler:

- akışı bakmadan açıklaman;
- davranışı çalıştırmadan doğru tahmin etmen;
- tasarım kararını ve trade-off'u savunman;
- failure'ı doğru sinyale bağlaman;
- aynı kavramı değiştirilmiş örneğe transfer etmen;
- worker diff'indeki hatayı veya eksikliği bulman.

Session sonunda lead tutor'a söyle:

```text
Bu task'taki öğrenme kanıtlarını değerlendir. Yalnızca gerçekten gösterdiğim
yetkinlikleri MASTERY.md'ye işle. Exposure ile mastery'yi ayır. Kayıtları
şirket ve repo bilgisinden tamamen arındır. Seviyesi değişmeyen kavramları da
zorla yükseltme.
```

## 13. Kayıtlara ne yazılır, ne yazılmaz?

Global profile taşınabilir kişisel yetenek kaydıdır; şirket task arşivi değildir.

Yazılabilir:

```text
Constructor injection ile dependency ownership ilişkisini açıkladı.
Transaction rollback davranışını farklı exception örneğine transfer etti.
At-least-once delivery için idempotency ihtiyacını bir failure üzerinden savundu.
```

Yazılmaz:

- şirket, müşteri, proje, repo, servis, class veya tablo adları;
- source code veya gerçek diff parçaları;
- internal endpoint, schema veya payload;
- ticket numarası;
- credential, token, production değeri;
- şirket içi mimariyi yeniden kurmaya yetecek ayrıntı.

Ürün reposundaki kodu sadece şirketçe onaylı AI araçlarıyla paylaş. Global profile'ın dışarı taşınabilir olması, şirket kodunu dışarı taşımaya izin vermez.

## 14. Task kapanış standardı

Task sonunda lead tutor şu üç sentez sorusunu **birer birer** sorar:

1. Değişen end-to-end flow nasıl ilerliyor?
2. En kritik framework veya tasarım mekanizması neden böyle çalışıyor?
3. Gerçekçi bir failure nedir ve bunu hangi sinyal yakalar?

Ardından iki ayrı sonuç verir:

```text
Delivery
Status: implemented | partially implemented | blocked
Spec: ...
Standards: ...
Validation: ...
Remaining risk: ...

Learning
Status: passed | in progress
Demonstrated concepts: ...
Mastery changes: ...
Next proof: ...
```

Final sentezde boşluk çıkarsa bütün task baştan anlatılmaz. Yalnızca boşluğun bulunduğu plan adımı tekrar açılır.

## 15. Hızlı karar tablosu

| Durum | Lead araç | Skill çağrısı | Implementasyon | Öğrenme yüzeyi |
| --- | --- | --- | --- | --- |
| Küçük/orta feature, lokal geliştirme | Windsurf veya Copilot | `ai-native-task-tutor` | Lead araç + sen | Mevcut repo ve oluşan küçük diff'ler |
| Büyük ve iyi tariflenmiş feature | Windsurf veya Copilot | `ai-native-task-tutor` | Digital Worker | Lokale çekilmiş gerçek worker diff'i |
| Bug/exception | Windsurf veya Copilot | `ai-native-task-tutor` + `diagnosing-bugs` | Lokal veya worker, plan kararına göre | Reproduction loop, kod ve fix diff'i |
| Performans gerilemesi | Windsurf veya Copilot | `ai-native-task-tutor` + `diagnosing-bugs` | Ölçümden sonra seçilir | Baseline, profiler/query plan ve diff |
| Sadece bir kavramı derinleştirme | Windsurf veya Copilot | `teach` | Gerekirse küçük deney | Repo örneği veya sanitize edilmiş örnek |
| Worker sonucu hazır, plan sohbeti yok | Windsurf veya Copilot | `ai-native-task-tutor` worker-review mode | Worker zaten bitirdi | Önce diff'ten geriye task modeli, sonra adım adım review |

## 16. Sorun giderme

### Skill görünmüyor

1. `~/.agents/skills/<skill-name>/SKILL.md` yolunu kontrol et.
2. Uygulamayı yeniden başlat.
3. Copilot CLI'da `/skills reload` ve `/skills info ai-native-task-tutor` çalıştır.
4. Windsurf'te Cascade Customizations → Skills ekranını kontrol et.
5. Açık invocation kullan: Windsurf'te `@ai-native-task-tutor`, Copilot'ta “Use the ai-native-task-tutor skill”.

### AI hemen kod yazıyor

```text
Stop implementation. Return to ai-native-task-tutor Phase 1. Stay read-only,
inspect the repository, and build the shared current/desired system model with
me before planning.
```

### AI bildiğin konuyu tekrar anlatıyor

```text
Read the relevant MASTERY.md row. Before explaining this concept, ask one
transfer question. If I answer causally, skip the lesson and continue at the
next useful layer.
```

### AI çok fazla teori anlatıyor

```text
Return to the current plan step. Teach only the causal prerequisites needed to
understand and verify this step. Put the rest under Next proof without teaching
it now.
```

### Digital Worker değişikliği planla uyuşmuyor

Worker özetine göre karar verme. Gerçek diff'i şu üç kümeye ayır:

- plana uyan değişiklikler;
- planda olup yapılmamış değişiklikler;
- planda olmayan ekstra değişiklikler.

Sonra spec ve standards review yap. Gerekirse lokal düzelt veya takımın normal süreciyle worker'a yeni implementation request gönder.

### Learning profile'a erişilemiyor

Onaylı ve her iki lokal aracın erişebildiği tek bir konum belirle; `AI_LEARNING_HOME` değişkenini ona yönlendir. Ürün repo içine ikinci bir `MASTERY.md` oluşturma. İki ayrı mastery kaynağı zamanla birbirinden kopar.

### Acil deadline var

Digital Worker implementation yolunu seçebilirsin. Fakat lokal diff incelemesi yapılmadan `Learning: passed` denmez. Süre kısıtlıysa yalnızca güvenli review için kritik plan adımlarını işle ve kalan kavramları `Next proof` olarak bırak; mastery seviyesini şişirme.

## 17. Kopyala-yapıştır promptları

- Genel task başlangıcı: [task-start.md](prompts/task-start.md)
- Digital Worker sonrası lokal diff inceleme: [digital-worker-review.md](prompts/digital-worker-review.md)
- Global Windsurf/Copilot davranış kuralı: [global-rule.md](prompts/global-rule.md)

Bu promptlar skill'in yerine geçmez. Skill'i açıkça çağırır ve o oturumdaki çalışma modunu netleştirir.
