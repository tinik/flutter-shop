class Product {
  final int id;
  final String sku;
  final String name;
  final double price;
  final String image;
  final String description;
  final int size;

  Product({
    required this.id,
    required this.sku,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.size,
  });
}

List<Product> products = [
  Product(
    id: 1,
    sku: "123451",
    name: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    price: 9999.2345,
    image: 'https://picsum.photos/640',
    description: 'Lorem ipsum is amet...',
    size: 12,
  ),
  Product(
    id: 2,
    sku: "123452",
    name: 'Product 2',
    price: 23.3456,
    image: 'https://picsum.photos/640',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin augue metus, tincidunt ac dolor sit amet, tempus condimentum ligula. Maecenas felis odio, bibendum a felis.',
    size: 14,
  ),
  Product(
    id: 3,
    sku: "123453",
    name: 'Product 3',
    price: 34.4567,
    image: 'https://picsum.photos/640',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin augue metus, tincidunt ac dolor sit amet, tempus condimentum ligula. Maecenas felis odio, bibendum a felis.',
    size: 24,
  ),
  Product(
    id: 4,
    sku: "123454",
    name: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    price: 45.5678,
    image: 'https://picsum.photos/640',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin augue metus, tincidunt ac dolor sit amet, tempus condimentum ligula. Maecenas felis odio, bibendum a felis.',
    size: 18,
  ),
  Product(
    id: 5,
    sku: "123455",
    name: 'Product 5',
    price: 56.5678,
    image: 'https://picsum.photos/640',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin augue metus, tincidunt ac dolor sit amet, tempus condimentum ligula. Maecenas felis odio, bibendum a felis.',
    size: 8,
  ),
  Product(
    id: 6,
    sku: "123456",
    name: 'Product 6',
    price: 67.5678,
    image: 'https://picsum.photos/640',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin augue metus, tincidunt ac dolor sit amet, tempus condimentum ligula. Maecenas felis odio, bibendum a felis.',
    size: 12,
  ),
];
