# JYLego
一个类似于SwiftUI写法一样的collectionView

写法如下,以viewModel为item去创建对应的collectionview
```Swift
var lego: KYLego {
        KYLego {
            KYLegoSection {
                viewModel.items
            }.sectionHeader(SectionHeaderViewModel())
            if viewModel.flag {
                KYLegoSection {
                    CollectionViewCellViewModel()
                    CollectionViewCellViewModel()
                }.sectionHeader(SectionHeaderViewModel())
            }
        }
    }
```
