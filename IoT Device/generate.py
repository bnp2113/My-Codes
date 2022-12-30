from pymongo import MongoClient
 import pandas as pd
 import matplotlib.pyplot as plt
 from datetime import datetime
 import numpy as np
 
 client = MongoClient()
 myDatabase = client['final']
 collection = myDatabase['data']
 
 records = collection.find({}, {"_id": 0}).limit(100)
 data = pd.DataFrame(records)
 save_results_to = "/home/ubuntu/plot/"
 plt.style.use('dark_background')
 
 def gen_gsr():
         data["gsr"] = data["gsr"].astype(int)
         sub_df = data["gsr"].where(data["gsr"] != 1024)
         avg = sub_df.mean()
         print(avg)
 
         plt.plot(data["time"], data["gsr"].astype(int))
         ax0 = plt.gca()
         ax0.set_yticks(ax0.get_yticks()[::5])
         ax0.set_xticks(ax0.get_xticks()[::5])
         plt.figtext(.75, .25, "avg = " + str(avg))
         plt.ylim([0, 1048])
         plt.yticks(np.arange(0, 1048, 96))
         plt.tight_layout()
         plt.savefig(save_results_to + 'gsr.png', dpi = 300, bbox_inches='tight')
         plt.clf()
 
 def gen_tp():
         data["tp"] = data["tp"].astype(float)
 
         avg = data["tp"].mean()
         print(avg)
         plt.plot(data["time"], data["tp"].astype(float))
         ax1 = plt.gca()
         ax1.set_yticks(ax1.get_yticks()[::5])
         ax1.set_xticks(ax1.get_xticks()[::5])
         plt.figtext(.75, .15, "avg = " + str(avg))
         plt.ylim([70, 105])
         plt.yticks(np.arange(70, 105, 2.5))
         plt.tight_layout()
         plt.savefig(save_results_to + 'tp.png', dpi = 300, bbox_inches='tight')
         plt.clf()
 
 def gen_hr():
 
 
         data["hr"] = data["hr"].astype(int)
         sub_df = data["hr"].where(data["hr"] != 0)
         avg = sub_df.mean()
         print(avg)
         plt.plot(data["time"], data["hr"].astype(int))
         ax2 = plt.gca()
         ax2.set_yticks(ax2.get_yticks()[::5])
         ax2.set_xticks(ax2.get_xticks()[::5])
 
         plt.figtext(.725, .8, "avg = " + str(avg) + "bpm")
         plt.ylim([0, 180])
         plt.yticks(np.arange(0, 180, 10))
         plt.tight_layout()
         plt.savefig(save_results_to + 'hr.png', dpi = 300, bbox_inches='tight')
         plt.clf()
 
 def gen_oxi():
 
 
         data["oxi"] = data["oxi"].astype(int)
         sub_df = data["oxi"].where(data["oxi"] != 0)
         avg = sub_df.mean()
         print(avg)
         plt.plot(data["time"], data["oxi"].astype(int))
         ax3 = plt.gca()
         ax3.set_yticks(ax3.get_yticks()[::5])
         ax3.set_xticks(ax3.get_xticks()[::5])
         plt.figtext(.725, .8, "avg = " + str(avg) + "%")
 
         plt.ylim([97, 100])
         plt.yticks(np.arange(95, 100, 0.5))
         plt.tight_layout()
         plt.savefig(save_results_to + 'oxi.png', dpi = 300, bbox_inches='tight')
         plt.clf()
