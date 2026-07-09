import threading
import time


class BankAccount:
    def __init__(self):
        self.balance = 100

    def withdraw(self, amount):
        # Paso 1: leer y validar saldo
        if self.balance >= amount:
            # Simula una pequeña demora entre validar y actualizar
            time.sleep(0.1)

            # Paso 2: actualizar saldo
            self.balance = self.balance - amount
            return True

        return False


def worker(account):
    success = account.withdraw(80)
    print(f"{threading.current_thread().name} retiro aprobado: {success}")


if __name__ == "__main__":
    account = BankAccount()

    t1 = threading.Thread(
        target=worker,
        args=(account,),
        name="Hilo-1"
    )

    t2 = threading.Thread(
        target=worker,
        args=(account,),
        name="Hilo-2"
    )

    t1.start()
    t2.start()

    t1.join()
    t2.join()

    print(f"Saldo final: {account.balance}")