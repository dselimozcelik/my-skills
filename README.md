# Selim'in AI-native engineering mentor sistemi

Bu repo bir backend kursu veya ürün uygulaması değildir. Şirket bilgisayarında Windsurf ve GitHub Copilot'a ortak bir çalışma biçimi ve kalıcı öğrenme hafızası kazandıran taşınabilir bir skill paketidir.

Amaç, AI ile hızlı çalışırken her önemli davranışı anlayabilmek, review edebilmek ve zaman içinde aynı konuları sıfırdan öğrenmemektir.

## Sistem ne yapar?

- Yeni bir codebase'i read-only tarar; mimarisini, ana akışlarını ve gerekli kavramlarını çıkarır.
- Kavramları `required now`, `required soon` ve `later` olarak önceliklendirir.
- Codebase gereksinimleriyle Selim'in kanıtlanmış mastery profilini karşılaştırır.
- Eksik kavramı ihtiyaç anında `teach` skill'ine otomatik devreder.
- Task'ları anlamsal bloklara ayırır; öğrenme ve açık onay olmadan implementasyona geçmez.
- Her bloktan sonra gerçek diff'i review eder, Selim'den explain-back ister ve doğrulamanın sınırını açıklar.
- Repo anlayışını ve öğrenme ilerlemesini repo dışında saklar; yeni chat veya araç değişiminde kaldığı yerden devam eder.

## Paketteki iki skill

| Skill | Sorumluluk |
| --- | --- |
| `engineering-mentor` | Repo anlama, task planlama, anlamsal bloklar, onaylar, implementasyon, review, verification ve repository memory. Normal kullanıcı giriş noktasıdır. |
| `teach` | Mentorun tespit ettiği tek bir kavram açığını kısa ve kanıta dayalı biçimde öğretir. Product kodunu değiştirmez; öğrenme sonucunu mentora döndürür. |

`teach`, Matt Pocock'un skill tasarımından uyarlanmıştır. Ayrıntılar [THIRD_PARTY.md](THIRD_PARTY.md) dosyasındadır.

## Skill ve hafıza neden ayrı?

```text
Git ile güncellenen skill paketi       Şirket bilgisayarındaki kalıcı durum
~/.agents/skills/                      ~/.ai-learning/backend-engineering/
├── engineering-mentor/                ├── learner/
└── teach/                             ├── repositories/
                                       └── active/
```

`learner/` taşınabilir ve sanitize edilmiş yetkinlik kanıtlarını tutar. `repositories/` şirkete özgü yerel mimari ve akış bilgisini tutar; kişisel Git reposuna veya dış servise gönderilmez. `active/`, yeni chat'in yarım kalan anlamsal bloktan devam etmesini sağlar.

## Ana workflow

```text
istek → ortak hafızayı yükle → çalışma modunu belirle
→ repo kanıtını çıkar → mastery gap analizi
→ gerekiyorsa teach → kullanıcı onayı
→ focused implementasyon → diff review → explain-back
→ verification ve sınırı → memory checkpoint
```

Mentor dört modda çalışır:

1. **Repository understanding:** read-only mimari, flow ve concept map çıkarma.
2. **Task delivery:** anlamsal bloklarla kontrollü geliştirme.
3. **Code/diff review:** değişiklik yapmadan davranış ve risk inceleme.
4. **Direct learning:** kavramı repository bağlamıyla `teach`e devretme.

## Anlamsal blok

Bir blok dosya sayısıyla değil tek bir davranış veya boundary ile tanımlanır. Örneğin request validation'ını transport sınırından service'e taşımak üç dosyaya dokunsa da tek blok olabilir; migration veya dış side effect ayrı blok olur.

Her blokta sabit sıra:

```text
orient → teach if needed → understanding check → explicit approval
→ implement → actual diff review → explain-back
→ focused verification → memory checkpoint
```

Plan dışı dependency, migration, external action, branch değişimi, commit, push, merge veya PR için yeni açıklama ve onay gerekir.

## Kurulum

Repo şirket bilgisayarına clone edildikten sonra:

### macOS / Linux

```bash
bash scripts/bootstrap.sh
```

Varsayılan symlink kurulumudur. Symlink yasaksa:

```bash
bash scripts/bootstrap.sh --copy
```

### Windows PowerShell

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\bootstrap.ps1
```

Varsayılan directory junction kurulumudur. Junction yasaksa:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\bootstrap.ps1 -Mode copy
```

Bootstrap:

- iki skill'i `~/.agents/skills/` altına kurar;
- learner, repositories ve active hafıza alanlarını oluşturur;
- mevcut profile dokunmaz;
- eski düz profile varsa yeni `learner/` yapısına yalnızca eksik hedefleri kopyalar;
- eski skill kurulumu görürse otomatik silmek yerine uyarır.

Özel konum gerekirse `AGENT_SKILLS_HOME` ve `AI_LEARNING_HOME` ortam değişkenleri kullanılabilir. Kurulumdan sonra Windsurf veya Copilot yeniden başlatılmalıdır.

## En kısa kullanım

Repo anlamak için [prompts/repository-understanding.md](prompts/repository-understanding.md), task için [prompts/task-start.md](prompts/task-start.md) kullanılabilir. Sürekli otomatik routing için [prompts/global-rule.md](prompts/global-rule.md) içeriğini aracın global instructions/rules alanına ekle.

Windsurf'te açık çağrı:

```text
@engineering-mentor Bu repoyu anlamak istiyorum.
```

Copilot'ta açık çağrı:

```text
Use the engineering-mentor skill. I want to understand this repository.
```

Skill açıklamaları otomatik invocation için tasarlanmıştır; açık çağrı yalnızca belirli bir oturumda kullanımı garanti etmek istediğinde gerekir.

## Güvenlik sınırı

Portable learner memory içine şirket/repo/servis/class/tablo adları, kaynak kod, yerel repo yolu, internal architecture, schema, payload, credential, müşteri verisi, endpoint veya production değeri yazılmaz.

Repository memory şirket bilgisi içerebilir fakat yalnızca şirket bilgisayarında tutulur. Şirket politikası ve onaylı AI araçları bu README'den üstündür.

Detaylı günlük kullanım ve sorun giderme için [KULLANIM_KILAVUZU.md](KULLANIM_KILAVUZU.md) dosyasına bak.
