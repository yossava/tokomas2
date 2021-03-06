import { PrismaClient, Prisma } from '@prisma/client'

const prisma = new PrismaClient()


export default async function handler(req, res) {
    let order;
    if (req.body.id) {
        var originalNota = await prisma.nota.findFirst({
            where: {
                id: req.body.id
            }
        });
        delete originalNota.id;
        delete originalNota.createdAt;
        var countLog = await prisma.notaEdited.count({
            where: {
                original_nota_id: req.body.id
            }
        });
        if (countLog == 0) {
            var createLog = await prisma.notaEdited.create({
                data: {
                    ...originalNota,
                    original_nota_id: req.body.id
                }
            });
        } else {
            var createLog = await prisma.notaEdited.updateMany({
                where: {
                    original_nota_id: req.body.id
                },
                data: {
                    ...originalNota,
                    original_nota_id: req.body.id
                }
            });
        }

        order = await prisma.nota.update({
            where: {
                id: req.body.id,
            },
            data: { ...req.body },
        })
    } else if (req.body.delete) {
        order = await prisma.nota.delete({
            where: {
                id: req.body.delete,
            }
        })
    } else {
        order = await prisma.nota.create({
            data: { ...req.body },
        })
        const items = JSON.parse(req.body.object)["item"];
        for (const key in items) {
            if (Object.hasOwnProperty.call(items, key)) {
                const el = items[key];
                const currentStock = await prisma.goldName.findFirst({
                    where: {
                        id: el.id
                    }
                })
                await prisma.goldName.update({
                    where: {
                        id: el.id
                    },
                    data: {
                        stock: (parseInt(currentStock.stock) - parseInt(el.qty)).toString()
                    }
                })
                await prisma.soldGold.create({
                    data: {
                        nota_id: order.id,
                        nomor_nota: order.nomor_nota,
                        name: el.nama,
                        berat: el.berat.toString(),
                        qty: el.qty.toString(),
                        total: el.total.toString(),
                        tipe: order.tipe,
                        gold_id: el.id
                    }
                })
            }
        }
    }

    res.status(200).json(order)

}