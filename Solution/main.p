import threading
import time


class BankAccount:

    def __init__(self):
        self.balance = 100
        self.lock = threading.Lock()

    def withdraw(self, amount):
        # Solo un hilo puede ejecutar esta sección a la vez
        with self.lock:

            if self.balance >= amount:

                # Simula procesamiento real antes de actualizar
                time.sleep(0.1)

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
