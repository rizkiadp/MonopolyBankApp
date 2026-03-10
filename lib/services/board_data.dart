import '../models/property.dart';

class BoardData {
  static List<Property> initialProperties = [
    // Brown
    Property(
        id: 'P01_JAKARTA',
        name: 'Jakarta',
        price: 600000,
        baseRent: 20000,
        colorGroupId: 'BROWN'),
    Property(
        id: 'P02_BEKASI',
        name: 'Bekasi',
        price: 600000,
        baseRent: 40000,
        colorGroupId: 'BROWN'),

    // Utility 1
    Property(
        id: 'P03_PT_BAKPIA',
        name: 'PT Bakpia',
        price: 1500000,
        baseRent: 0,
        colorGroupId: 'UTILITY'),

    // Light Blue
    Property(
        id: 'P04_BANTUL',
        name: 'Bantul',
        price: 1000000,
        baseRent: 60000,
        colorGroupId: 'LIGHT_BLUE'),
    Property(
        id: 'P05_GUNUNGKIDUL',
        name: 'Gunungkidul',
        price: 1000000,
        baseRent: 60000,
        colorGroupId: 'LIGHT_BLUE'),
    Property(
        id: 'P06_SLEMAN',
        name: 'Sleman',
        price: 1200000,
        baseRent: 80000,
        colorGroupId: 'LIGHT_BLUE'),

    // Pink
    Property(
        id: 'P07_PAPUA',
        name: 'Papua',
        price: 1400000,
        baseRent: 100000,
        colorGroupId: 'PINK'),
    Property(
        id: 'P09_MALUKU',
        name: 'Maluku',
        price: 1400000,
        baseRent: 100000,
        colorGroupId: 'PINK'),
    Property(
        id: 'P10_BALI',
        name: 'Bali',
        price: 1600000,
        baseRent: 120000,
        colorGroupId: 'PINK'),

    // Utility 2
    Property(
        id: 'P08_PT_EMAS',
        name: 'PT Emas',
        price: 1500000,
        baseRent: 0,
        colorGroupId: 'UTILITY'),

    // Orange
    Property(
        id: 'P11_NGAWI',
        name: 'Ngawi',
        price: 1800000,
        baseRent: 140000,
        colorGroupId: 'ORANGE'),
    Property(
        id: 'P12_MADIUN',
        name: 'Madiun',
        price: 1800000,
        baseRent: 140000,
        colorGroupId: 'ORANGE'),
    Property(
        id: 'P13_PONOROGO',
        name: 'Ponorogo',
        price: 2000000,
        baseRent: 160000,
        colorGroupId: 'ORANGE'),

    // Red
    Property(
        id: 'P14_JEMBER',
        name: 'Jember',
        price: 2200000,
        baseRent: 180000,
        colorGroupId: 'RED'),
    Property(
        id: 'P15_SURABAYA',
        name: 'Surabaya',
        price: 2200000,
        baseRent: 180000,
        colorGroupId: 'RED'),
    Property(
        id: 'P16_MALANG',
        name: 'Malang',
        price: 2400000,
        baseRent: 200000,
        colorGroupId: 'RED'),

    // Utility 3
    Property(
        id: 'P17_PT_GARUDA',
        name: 'PT Garuda',
        price: 1500000,
        baseRent: 0,
        colorGroupId: 'UTILITY'),

    // Yellow
    Property(
        id: 'P18_PURWODADI',
        name: 'Purwodadi',
        price: 2600000,
        baseRent: 220000,
        colorGroupId: 'YELLOW'),
    Property(
        id: 'P19_JEPARA',
        name: 'Jepara',
        price: 2600000,
        baseRent: 220000,
        colorGroupId: 'YELLOW'),
    Property(
        id: 'P20_SEMARANG',
        name: 'Semarang',
        price: 2800000,
        baseRent: 240000,
        colorGroupId: 'YELLOW'),

    // Green
    Property(
        id: 'P21_SOLO',
        name: 'Solo',
        price: 3000000,
        baseRent: 260000,
        colorGroupId: 'GREEN'),
    Property(
        id: 'P22_KLATEN',
        name: 'Klaten',
        price: 3000000,
        baseRent: 260000,
        colorGroupId: 'GREEN'),
    Property(
        id: 'P23_MAGELANG',
        name: 'Magelang',
        price: 3200000,
        baseRent: 280000,
        colorGroupId: 'GREEN'),

    // Blue
    Property(
        id: 'P24_PEMALANG',
        name: 'Pemalang',
        price: 3500000,
        baseRent: 350000,
        colorGroupId: 'BLUE'),
    Property(
        id: 'P25_TEGAL',
        name: 'Tegal',
        price: 4000000,
        baseRent: 500000,
        colorGroupId: 'BLUE'),
  ];
}