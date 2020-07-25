## VI. İşlemler
### Uygulamayı bir veya daha fazla bağımsız işlem olarak çalıştırma

Uygulama bir veya birden fazla *işlem* olarak çalıştırma ortamında çalıştırılır.

En basit senaryoda, kod bağımsız çalışan bir betiktir, çalışma ortamı ise geliştiricinin dil çalışma zamanı yüklenmiş bilgisayarıdır ve işlem komut satırı aracılığıyla başlatılır (Örneğin, `python my_script.py`). Spekturumun diğer ucunda, gelişmiş bir uygulamanın canlı yayın dağıtımı birden fazla [sıfır veya daha fazla aktif işlemi bulunan bir işlem tipi](./concurrency)ne sahip olabilir.

**On iki faktör işlemleri durumsuz ve [paylaşımsızdır](http://en.wikipedia.org/wiki/Shared_nothing_architecture).** Saklanmasına ihtiyaç duyulan herhangi bir veri, durum-sahibi bir [destek servisinde](./backing-services) saklanmalıdır. Bu servis genelde bir veritabanı olur.

İşlemler, bellekleri ve dosya sistemini, kısa süreli tek işlemli önbellekler olarak kullanabilirler. Örneğin, büyük bir dosya indiririp, üzerinde bir operasyon uygulayıp, operasyonun sonuçlarını veri tabanında saklayabilir. On iki faktör uygulaması, bellek veya diskte depolanmış hiçbir şeyin gelecekteki istek veya işlerde erişilebilir olacağını varsaymaz. Birden çok işlem çalıştıran sistemlerde, gelecekteki bir isteğin farklı bir işlem tarafından sunulma şansı yüksektir. Sadece bir süreç çalıştırıldığında bile, tekrar başlatma (kod dağıtımı, yapılandırma değişikliği veya çalışma ortamı işlemin farklı fiziksel adrese tekrar yerleştirimi tarafından tetiklenebilir) genellikle bütün yerel (bellek ve dosya sistemi v.b gibi) durumları temizler.

[django-assetpackager](http://code.google.com/p/django-assetpackager/) gibi statik içerik paketleyicileri dosya sistemini derlenmiş statikleri önbelleklemek için kullanır. On iki faktör uygulaması, bu derlemeyi uygulamanın derlenmesi aşamasında yapmayı tercih eder. [Jammit](http://documentcloud.github.com/jammit/) ve [Rails asset pipeline](http://ryanbigg.com/guides/asset_pipeline.html) gibi paketleyiciler derleme aşamasında çalışmak için yapılandırılabilir.

Bazı web sistemleri [yapışkan oturum (İng. sticky sessions)](http://en.wikipedia.org/wiki/Load_balancing_%28computing%29#Persistence) denilen giriş yapmış kullanıcı bilgisini uygulamanın belleğinde tutan yöntemi kullanır. "Sticky sessions" on iki faktör kurallarını ihlal eden bir yöntemdir ve asla kullanılmamalıdır. Oturum verisi [Memcached](http://memcached.org/) ve [Redis](http://redis.io/)gibi zaman aşımı özelliği sunan veritabanları için iyi bir veridir.
